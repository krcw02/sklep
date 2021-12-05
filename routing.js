const express = require('express')
const router = express.Router()
const bodyParser = require('body-parser');
const { json } = require('body-parser');
const cookieParser = require("cookie-parser");
const sessions = require('express-session');
var urlencodedParser = bodyParser.urlencoded({ extended: false })

var session;

router.get('/', function (req, res) {
    res.render('index')
})

router.get('/rejestracja', function (req, res) {
    if (req.session.userid) {
        res.render('/strona_glowna');
    }

    res.render('Rejestracja');
})

router.post('/rejestracja', urlencodedParser, async (req, res) => {
    if (req.session.userid) {
        res.render('/strona_glowna');
    }

    let email = req.body.email;
    let pass;
    if (req.body.pass[0] != req.body.pass[1]) {
        res.render('Rejestracja', { error: 'Podane hasła nie sa takie same!' });

    } else {
        pass = req.body.pass[0];
    }

    if (false) { // SQL jesli user jest w bazie
        res.render('Rejestracja', { error: 'Podany email jest już zajety' });

    } else {
        // SQL wpisanie usera do bazy $email $pass
        res.render('Logowanie');

    }


});

router.get('/logowanie', function (req, res) {

    if (req.session.userid) {
        res.render('strona_glowna');
    } else {
        res.render('Logowanie');
    }

})

router.post('/logowanie', urlencodedParser, async (req, res) => {

    if (req.session.userid) {
        res.render('strona_glowna');
    } else {
        let email = req.body.email;
        let pass = req.body.pass;

        req.session.userid = email

        if (true) { //SQL sprawdzenie czy dane logowania sa poprawne $email $pass
            res.render('strona_glowna');

        } else {
            res.render('Logowanie', { error: 'Login lub hasło są nieprawidłowe' });
        }
    }


});


module.exports = router