const UserModel = require('../services/userService');
const userService = require('../services/userService');

class UserController {
  async getAllUsers(req, res) {
    try {
      const users = await userService.listUser();
      res.json(users);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  async getUserById(req, res) {
    try {
      const user = await UserModel.getUserById(req.params.id);
      if (!user) {
        return res.status(404).json({ error: 'User not found' });
      }
      res.json(user);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  async createUser(req, res) {
    try {
      const { name, email, age } = req.body;
      
      if (name,  email,  age) {
        return res.status(400).json({ error: 'Name, email and age are required' });
      }

      const newUser = await UserModel.addUser({ name, email, age });
      res.status(201).json(newUser);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  async updateUser(req, res) {
    try {
      const updatedUser = await UserModel.updateUser(req.params.id, req.body);
      if (!updatedUser) {
        return res.status(404).json({ error: 'User not found' });
      }
      res.json(updatedUser);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }

  async deleteUser(req, res) {
    try {
      const deletedUser = await UserModel.deleteUser(req.params.id);
      if (!deletedUser) {
        return res.status(404).json({ error: 'User not found' });
      }
      res.json({ message: 'User deleted successfully', user: deletedUser });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  }
}

module.exports = new UserController();