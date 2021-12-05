const express = require('express')
const router = express.Router()
const bodyParser = require('body-parser');
const { json } = require('body-parser');
const knex = require('knex')({
    client: 'mysql',
    connection: {
        host : '127.0.0.1',
        port : 3306,
        user : 'root',
        password : '',
        database : 'sklep'
    }
});
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
    var response=true //Promise na sprawdzenie maila w bazie
    await knex.select('mail').table('uzytkownik').where('mail','like',email).then(rows=>{
        rows.forEach(row => {if(row.mail==email) {response=false; console.log(response)}})
    })

    if (req.body.pass[0] != req.body.pass[1]) {
        res.render('Rejestracja', { error: 'Podane hasła nie sa takie same!' });

    } else {
        pass = req.body.pass[0];
    }

    if (!response) { // SQL jesli user jest w bazie
        res.render('Rejestracja', { error: 'Podany email jest już zajety' });

    } else {
        let xd=knex('uzytkownik').insert({typ:'normalny',koszyk:'tak',haslo:pass,mail:email}).then( function (result) {
            console.log("true")
        })
        console.log(xd)
        console.log(response)
        res.render('Logowanie');
        console.log("XDDDD")

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