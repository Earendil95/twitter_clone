class CommentSerializer < ActiveModel::Serializer
  attributes :content, :user_id, :tweet_id
end