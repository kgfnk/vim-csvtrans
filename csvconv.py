import csv
def getDelimiter(data):
  if "\t" in data:
    return "\t"
  else:
    return ","

def transpose(range):
  delimiter = getDelimiter(range[0])
  return [delimiter.join(row) for row in zip(*csv.reader(range, delimiter=delimiter))]
