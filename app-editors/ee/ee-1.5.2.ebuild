# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="An easy to use text editor. A subset of aee"
#HOMEPAGE="http://mahon.cwx.net/ http://www.users.uswest.net/~hmahon/"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI="mirror://gentoo/${P}.src.tgz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~mips ppc ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="!app-editors/ersatz-emacs"
S="${WORKDIR}/easyedit-${PV}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-init-location.patch

	sed -i \
		-e "s/make -/\$(MAKE) -/g" \
		-e "/^buildee/s/$/ localmake/" \
		Makefile

	sed -i \
		-e "s/\tcc /\t\\\\\$(CC) /" \
		-e "/CFLAGS =/s/\" >/ \\\\\$(LDFLAGS)\" >/" \
		-e "/other_cflag/s/ *-s//" \
		create.make
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	dobin ee
	doman ee.1
	dodoc Changes README.ee ee.i18n.guide ee.msg
	keepdir /usr/share/${PN}
}
