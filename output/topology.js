var nodes = null;
var edges = null;
var network = null;
nodes = [];
// Create a data table with links.
edges = [];
var DIR = './images/';
// Create a data table with nodes.

nodes.push({id: 2, label: '0x2', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 3, label: '0x3', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 1, label: '0x1', image:DIR+'switch.jpg', shape: 'image'});

edges.push({from: 2, to: 1});

edges.push({from: 3, to: 2});

edges.push({from: 3, to: 1});

nodes.push({id: 92719437067906, label: '54:53:ed:1c:36:82', image:DIR+'host.png', shape: 'image'});

edges.push({from: 92719437067906, to: 3});

nodes.push({id: 160188717069, label: '00:25:4b:fd:d8:0d', image:DIR+'host.png', shape: 'image'});

edges.push({from: 160188717069, to: 1});

