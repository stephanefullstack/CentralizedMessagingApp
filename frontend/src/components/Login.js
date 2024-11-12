// src/components/Login.js
import React, { useState } from 'react';
import api from '../api';

const Login = () => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [errorMessage, setErrorMessage] = useState('');

  const handleLogin = async (e) => {
    e.preventDefault();
    try {
      const response = await api.post('/api/v1/users/sign_in', { // Assurez-vous que le chemin est correct
        user: { // Structure correcte pour correspondre au backend
          email: username,
          password: password,
        },
      });

      localStorage.setItem('token', response.data.token);
      window.location.href = '/Dashboard'; // Redirige vers le tableau de bord après connexion
    } catch (error) {
      setErrorMessage('Email ou mot de passe incorrect');
      console.error('Erreur de connexion', error);
    }
  };

  return (
    <div>
      <h1>Connexion</h1>
      {errorMessage && <p style={{ color: 'red' }}>{errorMessage}</p>}
      <form onSubmit={handleLogin}>
        <input
          type="text"
          placeholder="Nom d'utilisateur"
          value={username}
          onChange={(e) => setUsername(e.target.value)}
        />
        <input
          type="password"
          placeholder="Mot de passe"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
        />
        <button type="submit">Se connecter</button>
      </form>
    </div>
  );
};

export default Login;
