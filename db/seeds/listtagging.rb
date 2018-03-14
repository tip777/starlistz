list_itiran = List.all
list_itiran.each_with_index do |tag, i|
  target = ActsAsTaggableOn::Tagging.new(tag_id: i+11, taggable_type: "List", taggable_id: i+1, context: "tags")
  target.save

  random = Random.new
  n = random.rand(1..50)
  n2 = random.rand(61..74)
  target = ActsAsTaggableOn::Tagging.new(tag_id: n2, taggable_type: "List", taggable_id: n, context: "tags")
  target.save
end
