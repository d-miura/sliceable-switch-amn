require 'active_support/core_ext/class/attribute_accessors'
require 'drb'
require 'json'
require 'path_manager'
require 'port'
require 'slice_exceptions'
require 'slice_extensions'

# Virtual slice.
# rubocop:disable ClassLength
class Slice
  extend DRb::DRbUndumped
  include DRb::DRbUndumped

  cattr_accessor(:all, instance_reader: false) { [] }

  def self.create(name)
    if find_by(name: name)
      fail SliceAlreadyExistsError, "Slice #{name} already exists"
    end
    new(name).tap { |slice| all << slice }
  end

  def self.split(base, *into)
    base_slice = find_by!(base)#arg[0]:splited slice
    split_to_name = Array.new(into[0].split(":")[0], into[1].split(":")[0])
    split_to_name.each{|each| fail SliceAlreadyExistsError, "Slice #{each} already exists" if find_by(name: each)}

    hosts_mac_addrs = Array.new(into[0].split(":")[1].split(","), into[1].split(":")[1].split(","))
    ports = base_slice.ports
    macs = []
    ports.each{|each| macs << base_slice.mac_addresses(each)}
    split_to_name.zip(hosts_mac_addrs).each do |slice_name, mac_addrs|
      tmp_slice = create(slice_name)
      ports.each{|each| tmp_slice.add_port(each)}
      mac_addrs.each do |mac_addr|
        macs.zip(ports).each {|port,each| each.each{|mac| tmp_slice.add_mac_address(mac_addr, port) if mac == mac_addr}}
      end
    end
    destory(base)
    puts "split #{base} into #{into[0].split(":")[0]} and #{into[1].split(":")[0]}"
  end

  def self.join(*base, into)
    base_slices = {}.tap{|slices| base.each{|each| slices << find_by!(each)}}
    fail SliceAlreadyExistsError, "Slice #{into} already exists" if find_by(name: into)

    join_to = create(into)
    base_slices.each do |base_slice|
      base_slice.ports.each do |port|
        join_to.add_port(port) if !join_to.find_port(port)
        base_slice.mac_addresses(port).each{|mac| joint_to.add_mac_address(mac, port)}
      end
      destroy(base_slice)
    end
    puts "join #{base[0]} and #{base[1]} into #{into}"
  end

  # This method smells of :reek:NestedIterators but ignores them
  def self.find_by(queries)
    queries.inject(all) do |memo, (attr, value)|
      memo.find_all { |slice| slice.__send__(attr) == value }
    end.first
  end

  def self.find_by!(queries)
    find_by(queries) || fail(SliceNotFoundError,
                             "Slice #{queries.fetch(:name)} not found")
  end

  def self.find(&block)
    all.find(&block)
  end

  def self.destroy(name)
    find_by!(name: name)
    Path.find { |each| each.slice == name }.each(&:destroy)
    all.delete_if { |each| each.name == name }
  end

  def self.destroy_all
    all.clear
  end

  attr_reader :name

  def initialize(name)
    @name = name
    @ports = Hash.new([].freeze)
  end
  private_class_method :new

  def add_port(port_attrs)
    port = Port.new(port_attrs)
    if @ports.key?(port)
      fail PortAlreadyExistsError, "Port #{port.name} already exists"
    end
    @ports[port] = [].freeze
  end

  def delete_port(port_attrs)
    find_port port_attrs
    Path.find { |each| each.slice == @name }.select do |each|
      each.port?(Topology::Port.create(port_attrs))
    end.each(&:destroy)
    @ports.delete Port.new(port_attrs)
  end

  def find_port(port_attrs)
    mac_addresses port_attrs
    Port.new(port_attrs)
  end

  def each(&block)
    @ports.keys.each do |each|
      block.call each, @ports[each]
    end
  end

  def ports
    @ports.keys
  end

  def add_mac_address(mac_address, port_attrs)
    port = Port.new(port_attrs)
    if @ports[port].include? Pio::Mac.new(mac_address)
      fail(MacAddressAlreadyExistsError,
           "MAC address #{mac_address} already exists")
    end
    @ports[port] += [Pio::Mac.new(mac_address)]
  end

  def delete_mac_address(mac_address, port_attrs)
    find_mac_address port_attrs, mac_address
    @ports[Port.new(port_attrs)] -= [Pio::Mac.new(mac_address)]

    Path.find { |each| each.slice == @name }.select do |each|
      each.endpoints.include? [Pio::Mac.new(mac_address),
                               Topology::Port.create(port_attrs)]
    end.each(&:destroy)
  end

  def find_mac_address(port_attrs, mac_address)
    find_port port_attrs
    mac = Pio::Mac.new(mac_address)
    if @ports[Port.new(port_attrs)].include? mac
      mac
    else
      fail MacAddressNotFoundError, "MAC address #{mac_address} not found"
    end
  end

  def mac_addresses(port_attrs)
    port = Port.new(port_attrs)
    @ports.fetch(port)
  rescue KeyError
    raise PortNotFoundError, "Port #{port.name} not found"
  end

  def member?(host_id)
    @ports[Port.new(host_id)].include? host_id[:mac]
  rescue
    false
  end

  def to_s
    @name
  end

  def to_json(*_)
    %({"name": "#{@name}"})
  end

  def method_missing(method, *args, &block)
    @ports.__send__ method, *args, &block
  end
end
# rubocop:enable ClassLength
