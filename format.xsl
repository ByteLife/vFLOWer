<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:vco="http://vmware.com/vco/workflow"
	xmlns:trax="http://xml.apache.org/xslt"
>

	<xsl:output method="xml" version="1.0" indent="yes" trax:indent-amount="4"/>
	<xsl:strip-space elements="*"/>

	<xsl:template name="ltrim">
		<xsl:param name="text"/>
		<xsl:value-of select="substring($text, string-length(substring-before($text, substring(normalize-space($text), 1, 1))) + 1)"/>
	</xsl:template>

	<xsl:template name="getNumOfTrailingSpaces">
		<xsl:param name="text"/>
		<xsl:variable name="normalizedText">
			<xsl:value-of select="normalize-space($text)"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="string-length($normalizedText) > 0">
				<xsl:call-template name="getNumOfTrailingSpaces">
					<xsl:with-param name="text" select="substring-after(substring($text, string-length($normalizedText)), substring($normalizedText, string-length($normalizedText)))"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="string-length($text)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="rtrim">
		<xsl:param name="text"/>
		<xsl:variable name="numOfTrailingSpaces">
			<xsl:call-template name="getNumOfTrailingSpaces">
				<xsl:with-param name="text">
					<xsl:call-template name="ltrim">
						<xsl:with-param name="text" select="$text"/>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
		</xsl:variable>
		<xsl:value-of select="substring($text, 1, string-length($text) - $numOfTrailingSpaces)"/>
	</xsl:template>

	<xsl:template name="trim">
		<xsl:param name="text"/>
			<xsl:call-template name="rtrim">
				<xsl:with-param name="text">
					<xsl:call-template name="ltrim">
						<xsl:with-param name="text" select="$text"/>
					</xsl:call-template>
				</xsl:with-param>
			</xsl:call-template>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="text()">
		<xsl:variable name="trimmed">
			<xsl:call-template name="trim">
				<xsl:with-param name="text" select="."/>
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="parent::vco:script or parent::script or contains(., '&#xa;')">
			<xsl:text>&#xa;</xsl:text>
		</xsl:if>
		<xsl:value-of select="$trimmed"/>
		<xsl:if test="parent::vco:script or parent::script or contains(., '&#xa;')">
			<xsl:text>&#xa;</xsl:text>
			<!-- generate indent for closing tag -->
			<!-- get ancestor nodes except root element (which has no parent) -->
			<xsl:for-each select="ancestor::*[parent::*]">
				<xsl:text>    </xsl:text>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	<xsl:template match="vco:workflow | dunes-script-module | package | config-element">
		<xsl:text>&#xa;</xsl:text>
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="vco:workflow[not(allowed-operations)]/@api-version">
		<xsl:copy>
			<xsl:attribute name="allowed-operations">vfe</xsl:attribute>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="dunes-script-module[not(allowed-operations)]/@version">
		<xsl:copy>
			<xsl:attribute name="allowed-operations">vfe</xsl:attribute>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="vco:input | vco:output | vco:attrib[position() = 1] | vco:workflow-item
			| vco:position | vco:description[local-name(parent::*) != 'attrib'] | vco:in-binding
			| vco:out-binding | vco:script | vco:presentation
			| script | param">
		<xsl:if test="preceding-sibling::*">
			<xsl:text>&#xa;&#xa;</xsl:text>
			<!-- generate indent for opening tag -->
			<xsl:for-each select="ancestor::*">
				<xsl:text>    </xsl:text>
			</xsl:for-each>
		</xsl:if>
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
