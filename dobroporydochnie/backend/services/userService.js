const userModel = require('../models/userModel');

async function listUser() {
  return await userModel.getAllUsers;
}

async function addUser(userData) {
  return await userModel.addUser(userData);
}

async function getUserById(id) {
  return await userModel.getUserById(id);
}

async function updateUser(id, userData) {
  return await userModel.updateUser(id, userData);
}

async function deleteUser(id) {
  return await userModel.deleteUser(id);
}

// Дополнительные функции
async function searchUser(query) {
  const user = await userModel.getAllUsers();
  return user.filter(user => 
    user.title.toLowerCase().includes(query.toLowerCase()) ||
    user.description.toLowerCase().includes(query.toLowerCase())
  );
}


module.exports = {
  listUser,
  addUser,
  getUserById,
  updateUser,
  deleteUser,
  searchUser,
};