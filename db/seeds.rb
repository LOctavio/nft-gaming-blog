# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


luis = User.create!(name: 'Luis', photo: 'image1' , bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla aliquet et lorem at volutpat. Aenean vel justo diam. Vivamus ultricies vulputate dolor, et molestie turpis convallis et. In sed metus.', posts_counter: 0)
octavio = User.create!(name: 'Octavio', photo: 'image2', bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ullamcorper cursus sollicitudin. Etiam nulla augue, pretium at diam tempus, ornare mollis nunc. Ut enim dolor, fringilla vitae metus id, suscipit.', posts_counter: 0)
john = User.create!(name: 'Jhon', photo: 'image3', bio: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus tincidunt, leo vel cursus auctor, est sapien congue risus, non elementum est justo vel sem. Vestibulum blandit blandit eros eu interdum.', posts_counter: 0)

post1 = luis.posts.create!(title: 'New post 1', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin eros tellus, facilisis eget nisi sed, tempus laoreet neque. Nunc gravida sit amet elit in euismod. Etiam eu tincidunt augue. Fusce.', comments_counter: 0, likes_counter: 0)
post2 = luis.posts.create!(title: 'New post 2', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent elementum turpis in sapien feugiat, sit amet ultrices dui pretium. Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut.', comments_counter: 0, likes_counter: 0)
post3 = luis.posts.create!(title: 'New post 3', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla sit amet eros accumsan, cursus metus lobortis, tincidunt erat. Nam blandit odio risus, et placerat sem gravida vitae. Nunc rhoncus sollicitudin.', comments_counter: 0, likes_counter: 0)
post4 = luis.posts.create!(title: 'New post 4', text: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis a interdum odio. Cras dictum convallis euismod. Pellentesque imperdiet elementum augue ut bibendum. Donec ut risus urna. Etiam fringilla lacinia dui.', comments_counter: 0, likes_counter: 0)

octavio.comments.create!(text: 'really nice post Luis', post: post1)
john.comments.create!(text: 'Well Done 👏👏👏', post: post1)
john.comments.create!(text: 'Love 💓 it!!!', post: post1)