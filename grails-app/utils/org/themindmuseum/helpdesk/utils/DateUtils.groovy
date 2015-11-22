package org.themindmuseum.helpdesk.utils

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId
import java.time.format.DateTimeFormatter
import java.time.format.DateTimeParseException;
import java.util.Date;

public class DateUtils {

    public static final DEFAULT_DATE_FORMAT = 'MM/dd/yyyy'
    public static final DEFAULT_JQUERY_DATETIME_PICKER_FORMAT = DEFAULT_DATE_FORMAT + ' hh:mm a'

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
            return date ? LocalDateTime.parse(date?.toUpperCase(), DateTimeFormatter.ofPattern(DEFAULT_JQUERY_DATETIME_PICKER_FORMAT)) : null;
        }catch (DateTimeParseException e){
            e.printStackTrace()
            return null
        }
    }

    public static def formatJQueryDateTimeInput(LocalDateTime localDateTime){
        return localDateTime ? asDate(localDateTime).format(DEFAULT_JQUERY_DATETIME_PICKER_FORMAT) : ''
    }

    public static def formatJQueryDateInput(LocalDate localDate){
        return localDate ? asDate(localDate).format(DEFAULT_JQUERY_DATETIME_PICKER_FORMAT) : ''
    }

    public static def isPastAlready(LocalDate localDate){
        localDate?.compareTo(LocalDate.now()) < 0
    }

    public static def isPastAlready(LocalDateTime localDateTime){
        localDateTime?.compareTo(LocalDateTime.now()) < 0
    }
}