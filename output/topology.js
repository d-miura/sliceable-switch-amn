var nodes = null;
var edges = null;
var network = null;
nodes = [];
// Create a data table with links.
edges = [];
var DIR = './images/';
// Create a data table with nodes.

nodes.push({id: 6, label: '0x6', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 5, label: '0x5', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 2, label: '0x2', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 4, label: '0x4', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 1, label: '0x1', image:DIR+'switch.jpg', shape: 'image'});

nodes.push({id: 3, label: '0x3', image:DIR+'switch.jpg', shape: 'image'});

edges.push({from: 5, to: 3});

edges.push({from: 2, to: 1});

edges.push({from: 5, to: 1});

edges.push({from: 5, to: 4});

edges.push({from: 3, to: 2});

edges.push({from: 5, to: 6});

edges.push({from: 4, to: 1});

nodes.push({id: 18764998447377, label: '11:11:11:11:11:11', image:DIR+'host.png', shape: 'image'});

edges.push({from: 18764998447377, to: 1});

nodes.push({id: 37529996894754, label: '22:22:22:22:22:22', image:DIR+'host.png', shape: 'image'});

edges.push({from: 37529996894754, to: 4});

nodes.push({id: 56294995342131, label: '33:33:33:33:33:33', image:DIR+'host.png', shape: 'image'});

edges.push({from: 56294995342131, to: 5});

nodes.push({id: 75059993789508, label: '44:44:44:44:44:44', image:DIR+'host.png', shape: 'image'});

edges.push({from: 75059993789508, to: 6});

