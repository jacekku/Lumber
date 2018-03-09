function start(){
    let res=$.getJSON("http://www.ttss.krakow.pl/internetservice/geoserviceDispatcher/services/vehicleinfo/vehicles")
    res=res.responseJSON
console.log(res)
}
window.addEventListener("load",start)