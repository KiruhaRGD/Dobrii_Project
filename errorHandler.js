function errorHandler(req,res,next){
  const time = new Date().toLocaleTimeString("ru-RU",{hour: '2-digit', minute: '2-digit'});
  console.log(req.method, req.url, time);
  next()
}

module.exports = errorHandler;