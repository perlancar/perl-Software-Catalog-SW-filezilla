package Software::Catalog::SW::filezilla;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;

use Role::Tiny::With;
with 'Versioning::Scheme::Dotted';
with 'Software::Catalog::Role::Software';

use Software::Catalog::Util qw(extract_from_url);

sub archive_info {
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

sub available_versions { [501, "Not implemented"] }

sub canon2native_arch_map {
    return +{
        'linux-x86_64' => 'linux',
        'win32' => 'win32',
        'win64' => 'win64',
    },
}

sub download_url {
    my ($self, %args) = @_;

    # XXX version, language
    extract_from_url(
        url => "https://filezilla-project.org/download.php?platform=" . $self->_canon2native_arch($args{arch}),
        re  => qr! <a id="quickdownloadbuttonlink" href="([^"]+?)"!,
    );
}

sub homepage_url { "https://filezilla-project.org" }

sub is_dedicated_profile { 0 }

sub latest_version {
    my ($self, %args) = @_;

    extract_from_url(
        url => "https://filezilla-project.org/download.php?platform=" . $self->_canon2native_arch($args{arch}),
        re  => qr! <a id="quickdownloadbuttonlink" href="[^"]+/FileZilla_(\d+(?:\.\d+)*)!,
    );
}

sub release_note { [501, "Not implemented"] }

1;
# ABSTRACT: FileZilla

=for Pod::Coverage ^(.+)$
