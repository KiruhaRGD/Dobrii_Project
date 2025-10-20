//добавить, удалить, обновить, авторизация, ещё че то вроде было или не было, может всё уже
let users = [
  { id: 12,
    name: "asd",
  }
];

let films = [
  {
    id: "1",
    title: "The Matrix",
    year: 1999,
    genre: "Sci-Fi",
  },
  {
    id: "2", 
    title: "Interstellar",
    year: 2014,
    genre: "Sci-Fi",
  }
];

async function getAllUsers() {
  return films;
}

async function addUser(userData) {
  const newUser = {
    id: (users.length + 1).toString(),
    name: userData.name,
    email: userData.email,
    age: parseInt(userData.age),
  };
  
  users.push(newUser);
  return newUser;
}

async function deleteUser(id) {
  const index = users.findIndex(user => user.id === id);
  if (index === -1) return null;
  
  return users.splice(index, 1)[0];
}

async function updateUser(id, userData) {
  const index = users.findIndex(user => user.id === id);
  if (index === -1) return null;
  
  users[index] = {
    ...users[index],
    ...userData,
    updatedAt: new Date()
  };
  
  return users[index];
}

async function getUserById(id) {
  return users.find(user => user.id === id) || null;
}

module.exports = { 
  getAllUsers, 
  addUser, 
  deleteUser, 
  updateUser, 
  getUserById 
};