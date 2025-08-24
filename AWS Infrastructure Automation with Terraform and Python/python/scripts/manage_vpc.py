import boto3

def create_vpc(cidr_block):
    ec2 = boto3.client('ec2')
    response = ec2.create_vpc(CidrBlock=cidr_block)
    vpc_id = response['Vpc']['VpcId']
    print(f'VPC created with ID: {vpc_id}')
    return vpc_id

def tag_vpc(vpc_id, tags):
    ec2 = boto3.client('ec2')
    ec2.create_tags(Resources=[vpc_id], Tags=tags)
    print(f'VPC {vpc_id} tagged with {tags}')

def delete_vpc(vpc_id):
    ec2 = boto3.client('ec2')
    ec2.delete_vpc(VpcId=vpc_id)
    print(f'VPC {vpc_id} deleted')

if __name__ == "__main__":
    # Example usage
    vpc_id = create_vpc('10.0.0.0/16')
    tag_vpc(vpc_id, [{'Key': 'Name', 'Value': 'MyVPC'}])
    # Uncomment the line below to delete the VPC
    # delete_vpc(vpc_id)