%dw 2.0
import dw::core::Strings

import * from dw::core::Strings

import java!org::apache::commons::lang3::StringUtils
import java!org::apache::commons::lang3::BooleanUtils


fun capitalizeKey(value:String) = Strings::capitalize(value) ++ "Key"
fun defaultIfEmpty(value:String, defaultValue:String) = StringUtils::defaultIfEmpty(value, defaultValue)
fun format(now: DateTime) = now as String {format: "yyyyMMdd"}
fun trimKey(value)= if(trim(value) == "") null else trim(value)
fun toPhoneFormat(str: String) =
    "(" ++ str[0 to 2] ++ ") " ++ str[3 to 5] ++ "-" ++ str[6 to 9]
fun encryptAdn(value:String) = (value replace '0' with '*' replace '1' with 'C' replace '2' with '@' replace '3' with 'A' replace '4' with 'E' replace '5' with 'V' replace '6' with 'T' replace '7' with 'D' replace '8' with 'H' replace '9' with 'N')
fun decryptAdn(value:String) = (value replace '*' with '0' replace 'C' with '1' replace '@' with '2' replace 'A' with '3' replace 'E' with '4' replace 'V' with '5' replace 'T' with '6' replace 'D' with '7' replace 'H' with '8' replace 'N' with '9')
fun currencyKey(value) = if(isDecimal(value)==false) value+".00" else value
fun leftPad (value:String, size:Number) =  leftPadWithValue(value,size, " ")
fun leftPadWithValue (value:String, size:Number,defaultValue:String) =  StringUtils::leftPad(StringUtils::substring(value,0,size),size,defaultValue)
fun rightPad (value:String, size:Number) =  rightPadWithValue(value,size, " ")
fun rightPadWithValue (value:String, size:Number,defaultValue:String) =  StringUtils::rightPad(StringUtils::substring(value,0,size),size,defaultValue)
fun leftPadAdvantechField(value, size:Number,defaultValue:String) = 	(if ((isEmpty(trimKey(value))==false) and (trimKey(value)!="null")) (leftPadWithValue(trimKey(value), size,defaultValue)) else repeat(defaultValue, size))
fun rightPadAdvantechField(value, size:Number,defaultValue:String) = 	(if ((isEmpty(trimKey(value))==false) and (trimKey(value)!="null")) (rightPadWithValue(trimKey(value), size,defaultValue)) else repeat(defaultValue, size))
fun formatDate(dt) = (
	if ((dt == "00000000") or (dt == null) or (trimKey(dt)) == "")
		"00000000" 
    else if (dt matches /(19|20)\d\d(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])/)
    		dt as Date {format: "yyyyMMdd"} as String {format: "yyyy-MM-dd"}
    else if (dt matches /(0[1-9]|1[012])\/(0[1-9]|[12][0-9]|3[01])\/(19|20)\d\d/)
		dt as Date {format: "MM/dd/yyyy"} as String {format: "yyyy-MM-dd"}
    	else if (dt matches /(19|20)\d\d\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])/)
		dt as Date {format: "yyyy-MM-dd"} as String {format: "yyyy-MM-dd"}
    else if (dt matches /(19|20)\d\d\-([0-9]|1[012])\-([0-9]|[12][0-9]|3[01])/)
		dt as Date {format: "yyyy-M-d"} as String {format: "yyyy-MM-dd"}
    else if (dt matches /(19|20)\d\d\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])T(0[0-9]|1[012])\:([012345][0-9])\:([012345][0-9])/)
		dt as Date {format: "yyyy-MM-ddT00:00:00"} as String {format: "yyyy-MM-dd"}
    else ""
)
fun toBoolean(value) = BooleanUtils::toBooleanObject(value)