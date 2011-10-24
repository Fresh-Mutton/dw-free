#!/usr/bin/perl
#
# DW::External::Site::Diigo
#
# Class to support Diigo linking.
#
# Authors:
#      Mark Smith <mark@dreamwidth.org>
#      Ricky Buchanan <ricky@notdoneliving.net>
#
# Copyright (c) 2011 by Dreamwidth Studios, LLC.
#
# This program is free software; you may redistribute it and/or modify it under
# the same terms as Perl itself.  For a copy of the license, please reference
# 'perldoc perlartistic' or 'perldoc perlgpl'.
#

package DW::External::Site::Diigo;

use strict;
use base 'DW::External::Site';
use Carp qw/ croak /;


# new does nothing for these classes
sub new { croak 'cannot build with new'; }


# returns an object if we allow this domain; else undef
sub accepts {
    my ( $class, $parts ) = @_;

    # let's just assume the last two parts are good if we have them
    return undef unless scalar( @$parts ) >= 2;

    return bless { hostname => "$parts->[-2].$parts->[-1]" }, $class;
}


# argument: DW::External::User
# returns URL to this account's library
sub journal_url {
    my ( $self, $u ) = @_;
    croak 'need a DW::External::User'
        unless $u && ref $u eq 'DW::External::User';

    return 'http://' . $self->{hostname} . '/user/' . $u->user;
}


# argument: DW::External::User
# returns URL to this account's profile
sub profile_url {
    my ( $self, $u ) = @_;
    croak 'need a DW::External::User'
        unless $u && ref $u eq 'DW::External::User';

    return 'http://' . $self->{hostname} . '/profile/' . $u->user;
}


# argument: DW::External::User
# returns URL to the badge image (userhead icon) for this user
sub badge_image_url {
    my ( $self, $u ) = @_;
    croak 'need a DW::External::User'
        unless $u && ref $u eq 'DW::External::User';

    # for lack of anything better, let's use the favicon
    return "http://www.diigo.com/favicon.ico";
}


1;
