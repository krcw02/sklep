const express = require('express');
const path = require('path');

const port = process.env.PORT || 3000
const app = express()
app.set('view engine', 'hbs')

const publicPath = path.resolve(__dirname, "public");

app.use(express.static(publicPath));

app.get('/', function (req, res) {
  res.render('index')
})
 
app.listen(port)