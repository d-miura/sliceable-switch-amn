var nodes = null;
var edges = null;
var network = null;
nodes = [];
// Create a data table with links.
edges = [];
var DIR = './images/';
// Create a data table with nodes.

nodes.push({id: 5, label: '0x5', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 6, label: '0x6', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 13, label: '0xd', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 11, label: '0xb', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 9, label: '0x9', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 10, label: '0xa', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 15, label: '0xf', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 8, label: '0x8', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 4, label: '0x4', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 14, label: '0xe', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 7, label: '0x7', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 3, label: '0x3', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 12, label: '0xc', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 2, label: '0x2', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 16, label: '0x10', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 1, label: '0x1', image:DIR+'switch.jpg', shape: 'image'});

edges.push({from: 5, to: 1});

edges.push({from: 6, to: 10});

edges.push({from: 11, to: 3});

edges.push({from: 4, to: 3});

edges.push({from: 9, to: 2});

edges.push({from: 6, to: 5});

edges.push({from: 6, to: 7});

edges.push({from: 15, to: 7});

edges.push({from: 8, to: 7});

edges.push({from: 14, to: 16});

edges.push({from: 15, to: 16});

edges.push({from: 15, to: 14});

edges.push({from: 12, to: 11});

edges.push({from: 13, to: 12});

edges.push({from: 9, to: 8});

edges.push({from: 11, to: 10});

edges.push({from: 5, to: 4});

edges.push({from: 14, to: 13});

edges.push({from: 10, to: 9});

edges.push({from: 2, to: 3});

edges.push({from: 1, to: 2});

nodes.push({id: 127559408628893, label: '74:03:bd:3d:34:9d', image:DIR+'host.png', shape: 'image'});

edges.push({from: 127559408628893, to: 16});

nodes.push({id: 160188717069, label: '00:25:4b:fd:d8:0d', image:DIR+'host.png', shape: 'image'});

edges.push({from: 160188717069, to: 1});

