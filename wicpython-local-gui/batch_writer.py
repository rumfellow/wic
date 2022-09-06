import boto3
import csv
from uuid import uuid4
#data = open('testfile.tsv', 'r')
data = open('/home/alex/projects/aws/dictionaries/oxford5000/oxford_multilang_no_dups_shuffled.csv','r')
reader = csv.reader(data, delimiter=',')


dynamo = boto3.resource('dynamodb')
table = dynamo.Table('oxford5000')

with table.batch_writer() as bw:
    for row in reader:

        item={"category":row[2],"uuid":str(uuid4()),"translations":{"EN-US":row[0],"ES":row[3],"FR":row[4],"IT":row[5],"DE":row[6],"RU":row[7]}
}
        print(item)
        bw.put_item(Item=item)


