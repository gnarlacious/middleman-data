###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

# General configuration

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# User pages
data.users.each do |user|
	slug = user.name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
	proxy "/#{slug}/index.html", "/user.html", :locals => { :user => user }, :ignore => true
end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
  def slug(title)
		url = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
		return url
	end
end



# Build-specific configuration
configure :build do
	# Relative links for Github project page
	activate :relative_assets
	set :relative_links, true
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript
end

activate :deploy do |deploy|
	# Deploy to github pages
  deploy.deploy_method = :git
  # Optional Settings
  deploy.commit_message = 'Automated commit to :octocat:'
end
