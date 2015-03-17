# coding: utf-8
import csv
import vim
import re
from xml.sax.saxutils import *

def get_delimiter(data):
  if "\t" in data:
    return "\t"
  else:
    return ","

def sql_encode_row(row):
  result = []
  for column in row:
    result.append (sql_encode_value(column))
  return result

def sql_encode_value(value):
  if isnumber(value):
    return value.strip()
  elif value.upper() == "NULL":
    return value
  else:
    return "'" + value.strip().replace("'", "''") + "'"

def transpose(range):
  delimiter = get_delimiter(range[0])
  return [delimiter.join(row) for row in zip(*csv.reader(range, delimiter=delimiter))]

def isnumber(value):
  if re.match("^-?[0-9]+(.[0-9]+)?$", value):
    #頭0で始まる数字を文字として判定(001等)
    if re.match("^[0]+[0-9]+$", value):
      return False
    return True
  else:
    return False

def sql_select(range):
  table = vim.eval("a:table")
  delimiter = get_delimiter(range[0])
  reader = csv.reader(range, delimiter=delimiter)
  result = []
  header = ""
  key = ""
  sql = "select {0} from {1} where {2} = {3}"
  for i, row in enumerate(reader):
    if i == 0:
      header = row
      key = row[0]
      continue
    result.append(sql.format(", ".join(header).strip(), table, key.strip(), sql_encode_value(row[0])))
    continue
  return result

def sql_insert(range):
  table = vim.eval("a:table")
  delimiter = get_delimiter(range[0])
  reader = csv.reader(range, delimiter=delimiter)
  result = []
  header = ""
  sql = "insert into {0} ({1}) values ({2})"
  for i, row in enumerate(reader):
    if i == 0:
      header = ", ".join(row)
      continue
    result.append(sql.format(table, header.strip(), ", ".join(sql_encode_row(row))))
  return result

def sql_update(range):
  table = vim.eval("a:table")
  delimiter = get_delimiter(range[0])
  reader = csv.reader(range, delimiter=delimiter)
  result = []
  header = ""
  key = ""
  sql = "update {0} set {1} where {2} = {3}"
  for i, row in enumerate(reader):
    if i == 0:
      header = row
      key = row[0].strip()
      continue
    result.append(sql.format(table, make_sql_set(header, row), key, sql_encode_value(row[0])))
  return result

def make_sql_set(columns, values):
  list = []
  for i, column in enumerate(columns):
    if i == 0:
      continue
    list.append(column.strip() + " = " + sql_encode_value(values[i].strip()))
  return ", ".join(list)

def html_table(range):
  delimiter = get_delimiter(range[0])
  reader = csv.reader(range, delimiter=delimiter)
  result = []
  result.append("<table>")
  for i, row in enumerate(reader):
    result.append("  <tr>")
    for column in row:
      result.append("    <td>" + escape(column.strip()) + "</td>")
    result.append("  </tr>")
  result.append("</table>")
  return result

def html_div(range):
  delimiter = get_delimiter(range[0])
  reader = csv.reader(range, delimiter=delimiter)
  result = []
  for row in reader:
    result.append("<div>")
    for column in row:
      result.append("  <div>" + escape(column.strip()) + "</div>")
    result.append("</div>")
  return result

def html_select(range):
  delimiter = get_delimiter(range[0])
  reader = csv.reader(range, delimiter=delimiter)
  result = []
  result.append("<select>")
  for row in reader:
    result.append("  <option value=\"" + escape(row[0].strip()) + "\">" + escape(row[1].strip()) + "</option>")
  result.append("</select>")
  return result

def html_ul(range):
  delimiter = get_delimiter(range[0])
  reader = csv.reader(range, delimiter=delimiter)
  result = []
  result.append("<ul>")
  for row in reader:
    result.append("  <li>" + escape(row[0].strip()) + "</li>")
  result.append("</ul>")
  return result

def html_input(range):
  delimiter = get_delimiter(range[0])
  type = vim.eval("a:type")
  reader = csv.reader(range, delimiter=delimiter)
  result = []
  temp = "<input type=\"${type}\" id=\"${id}\" name=\"${name}\" value=\"${value}\" />"
  temp = temp.replace("${type}", type)
  for row in reader:
    html = temp
    html = html.replace("${id}", escape(row[0].strip()))
    html = html.replace("${name}", escape(row[0].strip()))
    html = html.replace("${value}", escape(row[1].strip()))
    result.append(html)
  return result
