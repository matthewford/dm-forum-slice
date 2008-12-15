# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dm-forum}
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matthew Ford"]
  s.date = %q{2008-12-15}
  s.description = %q{Merb Slice that provides datamapper forums}
  s.email = %q{mcf1986@gmail.com}
  s.extra_rdoc_files = ["README", "LICENSE", "TODO"]
  s.files = ["LICENSE", "README", "Rakefile", "TODO", "lib/dm-forum", "lib/dm-forum/merbtasks.rb", "lib/dm-forum/slicetasks.rb", "lib/dm-forum/spectasks.rb", "lib/dm-forum.rb", "spec/controllers", "spec/controllers/main_spec.rb", "spec/dm-forum_spec.rb", "spec/models", "spec/models/comment_spec.rb", "spec/models/discussion_spec.rb", "spec/models/forum_spec.rb", "spec/requests", "spec/requests/comments_spec.rb", "spec/requests/discussions_spec.rb", "spec/requests/forums_spec.rb", "spec/spec_helper.rb", "app/controllers", "app/controllers/application.rb", "app/controllers/comments.rb", "app/controllers/discussions.rb", "app/controllers/forums.rb", "app/helpers", "app/helpers/application_helper.rb", "app/helpers/comments_helper.rb", "app/helpers/discussions_helper.rb", "app/helpers/forums_helper.rb", "app/models", "app/models/comment.rb", "app/models/discussion.rb", "app/models/forum.rb", "app/views", "app/views/comments", "app/views/comments/_form.html.erb", "app/views/comments/edit.html.erb", "app/views/comments/index.html.erb", "app/views/comments/new.html.erb", "app/views/comments/show.html.erb", "app/views/discussions", "app/views/discussions/_form.html.erb", "app/views/discussions/edit.html.erb", "app/views/discussions/index.html.erb", "app/views/discussions/new.html.erb", "app/views/discussions/show.html.erb", "app/views/forums", "app/views/forums/_form.html.erb", "app/views/forums/edit.html.erb", "app/views/forums/index.html.erb", "app/views/forums/new.html.erb", "app/views/forums/show.html.erb", "app/views/layout", "app/views/layout/dm_forum.html.erb", "public/javascripts", "public/javascripts/master.js", "public/stylesheets", "public/stylesheets/master.css", "stubs/app", "stubs/app/controllers", "stubs/app/controllers/application.rb", "stubs/app/controllers/main.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://mcf1986.com/}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{merb}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Merb Slice that provides datamapper forums}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<merb-slices>, [">= 1.0.4"])
    else
      s.add_dependency(%q<merb-slices>, [">= 1.0.4"])
    end
  else
    s.add_dependency(%q<merb-slices>, [">= 1.0.4"])
  end
end
