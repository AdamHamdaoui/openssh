require 'spec_helper'

require_relative '../../../libraries/helpers.rb'

describe Openssh::Helpers do
  let(:chef_runner) { ChefSpec::ServerRunner.new }
  let(:chef_run) { chef_runner.converge(described_recipe) }
  let(:node) { chef_runner.node }

  let(:helper) do
    Object.new.extend(Openssh::Helpers)
  end

  describe '#keygen_platform?' do
    context 'on Amazon Linux' do
      let(:chef_runner) { ChefSpec::ServerRunner.new(platform: 'amazon', version: '2018.03') }

      it 'returns true' do
        expect(helper.keygen_platform?).to be_true
      end
    end

    context 'on RHEL 6' do
      before do
        node.normal['platform'] = 'redhat'
        node.normal['platform_version'] = '6.9'
      end

      it 'returns false' do
        expect(helper.keygen_platform?).to be_false
      end
    end

    context 'on RHEL 7' do
      before do
        node.normal['platform'] = 'redhat'
        node.normal['platform_version'] = '7.5'
      end

      it 'returns true' do
        expect(helper.keygen_platform?).to be_true
      end
    end
  end
end
