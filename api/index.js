const express = require('express');
const { lstat } = require('fs');
const app = express();

app.use(express.static(__dirname + '/web'));

app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Methods", "GET,PUT,PATCH,POST,DELETE");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
  });

app.use((_, res) => {
    res.redirect('/')
});

app.get('/', (_, res) => {
    res.sendFile('./web/index.html', { root: __dirname })
});

const port = 8080;
app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`)
});