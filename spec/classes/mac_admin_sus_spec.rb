require 'spec_helper'

describe 'mac_admin::sus' do
  let(:params) { {:sus_url_107 => 'http://example.com/content/catalogs/others/index-lion-snowleopard-leopard.merged-1_clients.sucatalog', :sus_url_108 => 'http://example.com/content/catalogs/others/index-mountainlion-lion-snowleopard-leopard.merged-1_clients.sucatalog'} }
  context 'running on a 10.7 machine' do
    let(:facts) { {:operatingsystem => 'Darwin', :macosx_productversion_major => '10.7'} }
    it do
      should contain_file('/var/lib/puppet/mac_admin/com.grahamgilbert.susprefs.mobileconfig').with_content('/^.*?index.*?$')
    end
  end
end