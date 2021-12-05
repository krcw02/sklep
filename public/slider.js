let config = {
    czas_zmiany: 2,
    src: ["img/0.jpg", "img/1.jpg"]
}
let slider = document.querySelector(".slider_image")
let wyswietlane_zdjecie = 0;
function doprzodu(){
    if (wyswietlane_zdjecie == config.src.length - 1) {
        $(".slider_image").fadeOut(300, () => {
            wyswietlane_zdjecie = 0
            slider.style.backgroundImage = `url(${config.src[wyswietlane_zdjecie]})`;
        }).fadeIn(300);

    } else {
        $(".slider_image").fadeOut(300, () => {
            wyswietlane_zdjecie++;
            slider.style.backgroundImage = `url(${config.src[wyswietlane_zdjecie]})`;
        }).fadeIn(300);
    }
}
function dotylu(){
    if (wyswietlane_zdjecie == 0) {
        $(".slider_image").fadeOut(300, () => {
            wyswietlane_zdjecie = config.src.length - 1
            slider.style.backgroundImage = `url(${config.src[wyswietlane_zdjecie]})`;
        }).fadeIn(300);

    } else {
        $(".slider_image").fadeOut(300, () => {
            wyswietlane_zdjecie--;
            slider.style.backgroundImage = `url(${config.src[wyswietlane_zdjecie]})`;
        }).fadeIn(300);
    }
}
document.querySelector(".left_button").addEventListener("click", dotylu)
document.querySelector(".left_button").addEventListener("click", dotylu)
document.querySelector(".right_button").addEventListener("click", doprzodu)
let interwal = setInterval(doprzodu,config.czas_zmiany*1000)
slider.addEventListener("mouseover", e => {
    clearInterval(interwal)
});
slider.addEventListener("mouseout", e => {
    interwal = setInterval(doprzodu,config.czas_zmiany*1000)
});