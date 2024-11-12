// src/components/Dashboard.js
import React, { useEffect, useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import api from '../api';
import CableApp from '../cable';

// Fonction pour récupérer les conversations depuis l'API
const fetchConversations = async () => {
  const { data } = await api.get('/conversations');
  return data;
};

const Dashboard = () => {
  const [conversations, setConversations] = useState([]);

  const { data, isLoading, error } = useQuery({
    queryKey: ['conversations'],
    queryFn: fetchConversations,
  });

  useEffect(() => {
    if (data) {
      setConversations(data);
      console.log("Conversations data:", data); // Débogage
    }
  }, [data]);


  useEffect(() => {
    const subscription = CableApp.cable.subscriptions.create(
      { channel: 'ConversationChannel' },
      {
        connected: () => console.log('Connected to WebSocket'),
        disconnected: () => console.log('Disconnected from WebSocket'),
        received: (payload) => {
          console.log('Received:', payload);
          const { type, data } = payload;

          if (type === 'newConversation') {
            setConversations((prevConversations) => [...prevConversations, data]);
          }

          if (type === 'newMessage') {
            setConversations((prevConversations) =>
              prevConversations.map((conversation) =>
                conversation.id === data.conversationId
                  ? { ...conversation, messages: [...conversation.messages, data] }
                  : conversation
              )
            );
          }
        },
      }
    );

    return () => {
      subscription.unsubscribe();
    };
  }, []);

  if (isLoading) return <p>Chargement...</p>;
  if (error) return <p>Erreur de chargement des conversations</p>;

  return (
    <div>
      <h1>Tableau de Bord</h1>
      <ul>
        {conversations.map((conversation) => (
          <li key={conversation.id}>
            {conversation.title}
            <ul>
              {conversation.messages && conversation.messages.map((msg) => (
                <li key={msg.id}>{msg.content}</li>
              ))}
            </ul>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default Dashboard;
