import csv
import vim
import re

def getDelimiter(data):
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
    return value
  else:
    return "'" + value + "'"

def transpose(range):
  delimiter = getDelimiter(range[0])
  return [delimiter.join(row) for row in zip(*csv.reader(range, delimiter=delimiter))]

#TODO:判断関数修正が必要
def isnumber(value):
  if re.match("^-?\d+(.\d+)?$", value):
    return False
  #頭0で始まる数字を文字として判定(001等)
  if re.match("^[0]+\d+$", value):
    return False
  return True

def sql_select(range):
  table = vim.eval("a:table")
  delimiter = getDelimiter(range[0])
  reader = csv.reader(range, delimiter=delimiter)
  result = []
  header = ""
  key = ""
  sql = "select {0} from {1} where {2} = {3}"
  for i, row in enumerate(reader):
    if i == 0:
      header = row
      key = row[0]
    result.append(sql.format(", ".join(header), table, key, sql_encode_value(row[0])))
    continue
  return result

def sql_insert(range):
  table = vim.eval("a:table")
  delimiter = getDelimiter(range[0])
  reader = csv.reader(range, delimiter=delimiter)
  result = []
  header = ""
  sql = "insert into {0} ({1}) values ({2})"
  for i, row in enumerate(reader):
    if i == 0:
      header = ", ".join(row)
      continue
    result.append(sql.format(table, header, ", ".join(sql_encode_row(row))))
  return result

def sql_update(range):
  table = vim.eval("a:table")
  delimiter = getDelimiter(range[0])
  reader = csv.reader(range, delimiter=delimiter)
  result = []
  header = ""
  key = ""
  sql = "update {0} set {1} where {2} = {3}"
  for i, row in enumerate(reader):
    if i == 0:
      header = row
      key = row[0]
      continue
    result.append(sql.format(table, make_sql_set(header, row), key, sql_encode_value(row[0])))
  return result

def make_sql_set(columns, values):
  result = []
  for i, column in enumerate(columns):
    result.append(column + " = " + sql_encode_value(values[i]))
  return ", ".join(result)
