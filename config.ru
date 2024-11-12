# Ce fichier est utilisé par les serveurs basés sur Rack pour démarrer l'application.

require_relative 'config/environment'

# Monter Action Cable à l'intérieur de l'application Rails
Rails.application.configure do
  # Ici, nous configurons Action Cable pour utiliser le chemin /cable
  config.action_cable.mount_path = '/cable'
end

# Démarrer l'application Rails
run Rails.application
