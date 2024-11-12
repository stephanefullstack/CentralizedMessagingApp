class SidekiqWorker
  include Sidekiq::Worker

  def perform(event_data)
    # Logique pour traiter les événements
    # Par exemple, analysez le type d'événement et répondez en conséquence
    event = JSON.parse(event_data)
    case event['object']
    when 'page'
      # Traitez les messages ou commentaires de page Facebook
    when 'instagram'
      # Traitez les événements Instagram
    end
  end
end
