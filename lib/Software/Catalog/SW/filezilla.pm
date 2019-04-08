package Software::Catalog::SW::filezilla;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Role::Tiny::With;
with 'Versioning::Scheme::Dotted';
with 'Software::Catalog::Role::Software';

use Software::Catalog::Util qw(extract_from_url);

sub meta {
    return {
        summary => "Cross-platform GUI FTP/SFTP client",
        homepage_url => "https://filezilla-project.org",
    };
}

sub get_latest_version {
    my ($self, %args) = @_;

    extract_from_url(
        url => "https://filezilla-project.org/download.php?platform=" . $self->_canon2native_arch($args{arch}),
        re  => qr! <a id="quickdownloadbuttonlink" href="[^"]+/FileZilla_(\d+(?:\.\d+)*)!,
    );
}

sub canon2native_arch_map {
    return +{
        'linux-x86_64' => 'linux',
        'win32' => 'win32',
        'win64' => 'win64',
    },
}

sub get_download_url {
    my ($self, %args) = @_;

    # XXX version, language
    extract_from_url(
        url => "https://filezilla-project.org/download.php?platform=" . $self->_canon2native_arch($args{arch}),
        re  => qr! <a id="quickdownloadbuttonlink" href="([^"]+?)"!,
    );
}

sub get_archive_info {
    my ($self, %args) = @_;
    [200, "OK", {
        programs => [
            {name=>"filezilla", path=>"/bin"},
            # XXX fzputtygen
            # XXX fzsftp
            # XXX fzstorj
        ],
    }];
}

1;
# ABSTRACT: FileZilla

=for Pod::Coverage ^(.+)$
