class Relationship < ApplicationRecord
  # フォローするMemberとの関係
  belongs_to :followed, class_name: "Member"
  # フォローしてくれているMemberとの関係
  belongs_to :follower, class_name: "Member"
end
