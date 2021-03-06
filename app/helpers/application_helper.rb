module ApplicationHelper
	def markdown(content)
		@markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, fenced_code_blocks: true, strikethrough: true, superscript: true, highlight: true, footnotes: true)
		@markdown.render(content)
	end
	
	def icon
		['genderless','mars','mars-stroke','venus','mercury','transgender','transgender-alt','neuter','ban','mars-double','venus-double','venus-mars','tree','bed','bug','bolt','eye','flask','heart','paw']
	end
	
	def display_avatar(user, size)
		if !user.use_icon
            I18n.t(:user_icon_helper, :icon => icon[user.icon.to_i], :size => size)
		elsif user.avatar.nil?
			I18n.t(:user_icon_helper, :icon => icon[user.icon.to_i], :size => size)
		else
			if size == '4x'
                I18n.t(:user_avatar_helper, :url => user.avatar.x4.url, :size => size)
			elsif size =='2x'
				I18n.t(:user_avatar_helper, :url => user.avatar.x2.url, :size => size)
			elsif size =='1x'
				I18n.t(:user_avatar_helper, :url => user.avatar.x1.url, :size => size)
			else
				I18n.t(:user_avatar_helper, :url => user.avatar.x4.url, :size => size)
			end
		end
	#	unless user.avatar.nil? 
	#		image_tag(user.avatar.file_name) 
	#	else
	#		image_tag("/path/to/fallback.jpg")
	#	end		
	end
	
	def test_group?(item)
		(item.groups.first.nil? || (!current_user.nil? && (current_user.id == item.user_id || current_user.shares_any_group?(item))))
	end
	
	def display_badge(role)
		case role
		when :superadmin
			'<i class="fa fa-eye fa-lg" title="superadmin"></i>'.html_safe
		when :admin
			'<i class="fa fa-heartbeat fa-lg" title="administrator"></i>'.html_safe
		when :moderator
			'<i class="fa fa-legal fa-lg" title="moderator"></i>'.html_safe
		when :editor
			'<i class="fa fa-magic fa-lg" title="editor"></i>'.html_safe
		when :author
			'<i class="fa fa-pencil fa-lg" title="author"></i>'.html_safe
		when :commenter
			'<i class="fa fa-comment fa-lg" title="commenter"></i>'.html_safe
		else
			'no'
		end
	end
  
  def cache_key_for_menus
    count          = Menu.count
		max_updated_at = Menu.maximum(:updated_at).try(:utc).try(:to_s, :number)
		"menus/all-#{count}-#{max_updated_at}"
	end
end
