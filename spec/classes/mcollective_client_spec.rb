#!/usr/bin/env rspec

require 'spec_helper'

describe 'mcollective::client', :type => :class do
  let(:facts) do
    { :operatingsystem => 'redhat' }
  end

  describe 'when only the mandatory parameters are provided' do
    let(:params) do
      {}
    end

    it 'should always be included' do
      subject.should contain_class('mcollective::client')
    end
  end
end
