package HTML::CSSInliner;
use strict;
use warnings;
our $VERSION = '0.01';
use CSS::Tiny;
use base 'Class::Accessor::Fast';

sub inline {
    my ($self, $css, $src) = @_;
    Carp::croak 'missing args' unless @_ == 3;

    # hr タグの変換
    if ($css->{hr}) {
        my $color = $css->{hr}->{color} || $css->{hr}->{'border-color'};
        if ($color) {
            $src =~ s{<hr([^>]*?)/?>}{
                "<hr$1 style='color: $color; border-color: $color;' />";
            }ge;
        }
    }

    # class の適用
    $src =~ s{<([^<>]+class=['"]?([^<>'"]+)['"]?[^<>]*)>}{
        my $e;
        while (my ($key , $val) = each %{ $css->{".$2"} }) {
            $e .= "$key: $val;";
        }
        "<$1 style='$e'>";
    }ge;

    $src;
}

1;
__END__

=encoding utf8

=head1 NAME

HTML::CSSInliner -

=head1 SYNOPSIS

  use HTML::CSSInliner;

=head1 DESCRIPTION

DoCoMo 端末は CSS を外部ファイルに分離することができないため、サーバサイドで適用する。

HTML::DoCoMoCSS という同等の機能をもつモジュールが CPAN にあがっているが、これは実行効率が悪いため車輪を再発明する。

HTML::DoCoMoCSS は、肝要なポリシーにしたがって実装されており、フルスペックの CSS をサポートしているのが遅い原因なので、本モジュールでは機能をしぼり、速度を向上させる。

    - hr タグおよび .Foo の2種類のタグのみをサポートする
    - 正規表現で実現する(はずれても泣かない)

=head1 REPOSITORY

http://github.com/tokuhirom/html--cssinliner/tree/master

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom @*(#RJKLFHFSDLJF gmail.comE<gt>

=head1 SEE ALSO

L<HTML::DoCoMoCSS>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
