class Hash
  def self.generate content
    Digest::SHA256.hexdigest content
  end
end
