require 'rails_helper'

describe LikesHelper, type: :helper do
  describe 'likeable_tag' do
    let(:user) { create :user }
    let(:topic) { create :topic }

    it 'should run with nil param' do
      allow(helper).to receive(:current_user).and_return(nil)
      expect(helper.likeable_tag(nil)).to eq('')
    end

    it 'should result when logined user liked' do
      allow(helper).to receive(:current_user).and_return(user)
      allow(topic).to receive(:liked_by_user?).and_return(true)
      expect(helper.likeable_tag(topic)).to eq(%(<a title=\"取消赞\" data-count=\"0\" data-state=\"active\" data-type=\"Topic\" data-id=\"1\" class=\"likeable active\" href=\"#\"><i class=\"fa fa-heart\"></i> <span></span></a>))
      allow(topic).to receive(:likes_count).and_return(3)
      expect(helper.likeable_tag(topic)).to eq(%(<a title=\"取消赞\" data-count=\"3\" data-state=\"active\" data-type=\"Topic\" data-id=\"1\" class=\"likeable active\" href=\"#\"><i class=\"fa fa-heart\"></i> <span>3 个赞</span></a>))
    end

    it 'should result when unlogin user' do
      allow(helper).to receive(:current_user).and_return(nil)
      expect(helper.likeable_tag(topic)).to eq(%(<a class=\"\" href=\"/account/sign_in\"><i class=\"fa fa-heart-o\"></i> <span></span></a>))
    end

    it 'should result with no_cache params' do
      str = %(<a title=\"赞\" data-count=\"0\" data-state=\"\" data-type=\"Topic\" data-id=\"1\" class=\"likeable \" href=\"#\"><i class=\"fa fa-heart-o\"></i> <span></span></a>)
      allow(helper).to receive(:current_user).and_return(user)
      expect(helper.likeable_tag(topic, cache: true)).to eq(str)
    end
  end
end
