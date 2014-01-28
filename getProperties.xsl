<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="text"/>
	<xsl:strip-space elements="*"/>

	<xsl:template match="/properties">
		<!-- Package meta info -->
		<xsl:apply-templates select="entry[@key = 'pkg-id']"/>
		<xsl:apply-templates select="entry[@key = 'pkg-description']"/>

		<!-- Element meta info -->
		<xsl:apply-templates select="entry[@key = 'id']"/>
		<xsl:apply-templates select="entry[@key = 'type']"/>
	</xsl:template>

	<xsl:template match="entry">
		<xsl:text>entry.</xsl:text>
		<xsl:value-of select="@key"/>
		<xsl:text> = </xsl:text>
		<xsl:value-of select="."/>
		<xsl:text>&#xa;</xsl:text>
	</xsl:template>

	<xsl:template match="/categories">
		<xsl:text>element.category = </xsl:text>
		<xsl:variable name="path">
			<xsl:for-each select="category">
				<xsl:value-of select="name"/>
				<xsl:text>/</xsl:text>
			</xsl:for-each>
		</xsl:variable>
		<xsl:value-of select="$path"/>
		<xsl:text>&#xa;</xsl:text>
	</xsl:template>

</xsl:stylesheet>
