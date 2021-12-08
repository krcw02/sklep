const express = require('express')
const router = express.Router()
const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');

const {json} = require('body-parser');
const knex = require('knex')({
    client: 'mysql',
    connection: {
        host: '127.0.0.1',
        port: 3306,
        user: 'sklep', // root on windows
        password: '',
        database: 'sklep'
    }
});
const cookieParser = require("cookie-parser");
const sessions = require('express-session');
var urlencodedParser = bodyParser.urlencoded({extended: false})

var session;

router.get('/', function (req, res) {
    res.render('strona_glowna')
})

router.get('/rejestracja', function (req, res) {
    if (req.session.userid) {
        res.render('strona_glowna');
    }

    res.render('Rejestracja');
})

router.post('/rejestracja', urlencodedParser, async (req, res) => {
    if (req.session.userid) {
        res.render('strona_glowna');
    }
    
    let email = req.body.email;
    let pass;
    let response = true //Promise na sprawdzenie maila w bazie
    if (req.body.pass[0] != req.body.pass[1]) {
        res.render('Rejestracja', {error: 'Podane hasła nie sa takie same!'});
        
    } else {
        pass = req.body.pass[0];
        if(email.length < 1 || pass.length < 1){
            res.render('Rejestracja', {error: 'Pola nie mogą być puste'});
        }
    }

    await knex.select('mail').table('uzytkownik').where('mail', 'like', email).then(rows => {
        rows.forEach(row => {
            if (row.mail == email) {
                response = false
            }
        })
    })
    

    if (!response) { // SQL jesli user jest w bazie
        res.render('Rejestracja', {error: 'Podany email jest już zajety'});

    } else {
        bcrypt.genSalt(10, function (err, salt) {
            bcrypt.hash(pass, salt, function (err, hash) {
                knex('uzytkownik').insert({
                    typ: 'normalny',
                    koszyk: 'tak',
                    haslo: hash,
                    mail: email
                }).then(function (result) {
                })
                res.render('Logowanie');
            })
        })


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
        let loginres
        await knex.select('mail', 'haslo').table('uzytkownik').where('mail', 'like', email).then(rows => {
            rows.forEach(row => {
                bcrypt.compare(pass, row.haslo, function (err, result) {
                    if (err)
                        console.log(err)
                    if (result) {
                        req.session.userid = email
                        res.render('strona_glowna')
                    } else
                        res.render('Logowanie', {error: 'Login lub hasło są nieprawidłowe'});

                })
            })
        })
    }


});


module.exports = router