package org.themindmuseum.helpdesk.utils

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId
import java.time.format.DateTimeFormatter
import java.time.format.DateTimeParseException;
import java.util.Date;

public class DateUtils {

    public static final DEFAULT_JQUERY_DATETIME_PICKER_FORMAT = 'MM/dd/yyyy hh:mm a'

    public static Date asDate(LocalDate localDate) {
        return Date.from(localDate.atStartOfDay().atZone(ZoneId.systemDefault()).toInstant());
    }

    public static Date asDate(LocalDateTime localDateTime) {
        return Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
    }

    public static LocalDate asLocalDate(Date date) {
        return Instant.ofEpochMilli(date.getTime()).atZone(ZoneId.systemDefault()).toLocalDate();
    }

    public static LocalDateTime asLocalDateTime(Date date) {
        return Instant.ofEpochMilli(date.getTime()).atZone(ZoneId.systemDefault()).toLocalDateTime();
    }

    public static def tryParseLocalDateTimeFromDateTimePicker(String date){
        try{
            //10/21/2015 12:00 pm
            return LocalDateTime.parse(date.toUpperCase(), DateTimeFormatter.ofPattern(DEFAULT_JQUERY_DATETIME_PICKER_FORMAT));
        }catch (DateTimeParseException e){
            e.printStackTrace()
            return null
        }
    }

    public static def String formatJQueryDateTimeInput(LocalDateTime localDateTime){
        return localDateTime ? asDate(localDateTime).format(DEFAULT_JQUERY_DATETIME_PICKER_FORMAT) : ''
    }
}