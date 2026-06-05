<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes"/>
    <xsl:template match="/">
        <processedOrder>
            <id><xsl:value-of select="//id"/></id>
            <item><xsl:value-of select="//item"/></item>
            <qty><xsl:value-of select="//qty"/></qty>
            <status>ENRICHED</status>
            <timestamp></timestamp>
        </processedOrder>
    </xsl:template>
</xsl:stylesheet>