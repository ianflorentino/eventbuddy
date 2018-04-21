class HomeSerializer < UserSerializer
  has_many :events, serializer: EventLightSerializer
end
