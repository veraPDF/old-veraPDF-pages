<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron">
    <ns uri="http://www.verapdf.org/MachineReadableReport" prefix="vmrr"/>
    <pattern>
        <rule context="/vmrr:report/vmrr:documentInfo/vmrr:pdfVersion">
            <report test="number(current()) &lt; 1.6">
                Policy check error: the PDF version is <value-of select="current()"/>. The PDF version must be 1.6 or greater!
            </report>
        </rule>
    </pattern>
    <pattern>
        <rule context="/vmrr:report/vmrr:validationInfo/vmrr:result/vmrr:summary/@warnings">
            <report test="number(current()) != 0">
                Policy check error: the document was validated with <value-of select="current()"/> warnings. The validation must be completed without any warnings!
            </report>
        </rule>
    </pattern>
    <pattern>
        <rule context="/vmrr:report/vmrr:pdfFeatures/vmrr:documentSecurity/vmrr:encrypted">
            <report test="current() != 'None'">
                Policy check error: the document encryption is '<value-of select="current()"/>'. The document must be not encrypted!
            </report>
        </rule>
    </pattern>
    <pattern>
        <rule context="/vmrr:report/vmrr:pdfFeatures/vmrr:lowLevelInfo/vmrr:filters/vmrr:filter">
            <report test="count(current()[@name='JBIG2Decode']) > 0">
                Policy check error: usage of the filter JBIG2Decode in the document is not allowed!
            </report>
            <report test="count(current()[@name='JPXDecode']) > 0">
                Policy check error: usage of the filter JPXDecode in the document is not allowed!
            </report>
        </rule>
    </pattern>
    <pattern>
        <rule context="/vmrr:report/vmrr:pdfFeatures/vmrr:pages/vmrr:page">
            <report test="number(current()/vmrr:rotation) != 0">
                Policy check error: the page with id='<value-of select="current()/@id"/>' is rotated. The document pages must not be rotated!
            </report>
            <report test="number(current()/vmrr:scaling) != 1">
                Policy check error: the page with id='<value-of select="current()/@id"/>' is scaled. The document pages must not be scaled!
            </report>
        </rule>
    </pattern>
    <pattern>
        <rule context="/vmrr:report/vmrr:pdfFeatures/vmrr:pages/vmrr:page[@orderNumber='1']/vmrr:resources/vmrr:images">
            <report test="count(current()/vmrr:image) > 0">
                Policy check error: the first page contains image with id='<value-of select="current()/vmrr:image/@id"/>'. The first page of the document must not contain images!
            </report>
        </rule>
    </pattern>
    <pattern>
        <rule context="/vmrr:report/vmrr:pdfFeatures/vmrr:pages/vmrr:page[@orderNumber='1']/vmrr:resources/vmrr:fonts/vmrr:font">
            <report test="/vmrr:report/vmrr:pdfFeatures/vmrr:documentResources/vmrr:fonts/vmrr:font[@id=current()/@id]/vmrr:encoding != 'StandardEncoding'">
                Policy check error: the first page uses font with id='<value-of select="current()/@id"/>' with encoding '<value-of select="/vmrr:report/vmrr:pdfFeatures/vmrr:documentResources/vmrr:fonts/vmrr:font[@id=current()/@id]/vmrr:encoding"/>'. The fonts used on the first page of the document must have 'StandardEncoding' only!
            </report>
        </rule>
    </pattern>
</schema>