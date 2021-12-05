const express = require('express');
const session = require('express-session')
const path = require('path');
const bodyParser = require('body-parser');
const { json } = require('body-parser');
const cookieParser = require("cookie-parser");
const sessions = require('express-session');
const port = process.env.PORT || 2000
const app = express()
app.set('view engine', 'hbs')

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
var urlencodedParser = bodyParser.urlencoded({ extended: false })
const publicPath = path.resolve(__dirname, "public");

const oneDay = 1000 * 60 * 60 * 24;

app.use(sessions({
  secret: "lhjksdbfjebacczarnychawdawndk",
  saveUninitialized:true,
  cookie: { maxAge: oneDay },
  resave: false
}));

const routing = require('./routing');
app.use('/', routing);

app.use(express.static(publicPath));


app.listen(port)