const userModel = require('../models/userModel');

async function listusers() {
  return await userModel.getAllusers();
}

async function createuser(userData) {
  return await userModel.adduser(userData);
}

async function getuserById(id) {
  return await userModel.getuserById(id);
}

async function updateuser(id, userData) {
  return await userModel.updateuser(id, userData);
}

async function deleteuser(id) {
  return await userModel.deleteuser(id);
}

// Дополнительные функции
async function searchusers(query) {
  const users = await userModel.getAllusers();
  return users.filter(user => 
    user.title.toLowerCase().includes(query.toLowerCase()) ||
    user.description.toLowerCase().includes(query.toLowerCase())
  );
}

async function getusersByGenre(genre) {
  const users = await userModel.getAllusers();
  return users.filter(user => 
    user.genre.toLowerCase() === genre.toLowerCase()
  );
}

module.exports = {
  listusers,
  createuser,
  getuserById,
  updateuser,
  deleteuser,
  searchusers,
  getusersByGenre
};