load ../bats_setup
load ../bats_zencode
SUBDOC=scope

@test "Zencode scope=given for schema introspection" {
    cat <<EOF | save myNestedRepetitveObject.json
{
   "myFirstObject":{
      "myNumber":11223344,
      "myString":"Hello World!",
      "myStringArray":[
         "String1",
         "String2",
         "String3",
         "String4"
      ]
   },
   "mySecondObject":{
      "mySecondNumber":1234567890,
	  "mySecondString":"Oh, hello again!",
      "myStringArray":[
         "anotherString1",
         "anotherString2",
         "anotherString3",
         "anotherString4"
      ]
   },
	 "Alice":{
		  "keyring":{
			 "ecdh":"AxLMXkey00i2BD675vpMQ8WhP/CwEfmdRr+BtpuJ2rM="
		  }
	   }
}
EOF
	conf="scope=given"
	cat <<EOF | zexe given_only.zen myNestedRepetitveObject.json
Given I am 'Alice'
And I have my 'keyring'
And I have a 'string dictionary' named 'myFirstObject'
And I have a 'string dictionary' named 'mySecondObject'
# The When section should be ignored
When I create the random 'random'
Then print codec
EOF
	save_output given_only_schema_output.json
	assert_output '{"CODEC":{"keyring":{"encoding":"complex","name":"keyring","root":"Alice","schema":"keyring","zentype":"e"},"myFirstObject":{"encoding":"string","name":"myFirstObject","zentype":"d"},"mySecondObject":{"encoding":"string","name":"mySecondObject","zentype":"d"}}}'
}

@test "Zencode scope=given with missing element" {
    cat <<EOF | save myNestedRepetitveObject.json
{
   "myFirstObject":{
      "myNumber":11223344,
      "myString":"Hello World!",
      "myStringArray":[
         "String1",
         "String2",
         "String3",
         "String4"
      ]
   }
}
EOF
	conf="scope=given"
	cat <<EOF | zexe given_only.zen myNestedRepetitveObject.json
#Given I am 'Alice'
#And I have my 'keyring'
Given I have a 'string dictionary' named 'myFirstObject'
And I have a 'string' named 'does not exists'
When I create the random 'random'
Then print codec
EOF
	save_output given_schema_missing.json
	assert_output '{"CODEC":{"does_not_exists":{"encoding":"string","missing":true,"name":"does_not_exists","zentype":"e"},"myFirstObject":{"encoding":"string","name":"myFirstObject","zentype":"d"}}}'
}

@test "Zencode scope=given with missing dictionary or array" {
    cat <<EOF | save myNestedRepetitveObject.json
{
   "myDictionary":{
      "myNumber":11223344,
      "myString":"Hello World!",
   },
   "myArray":[
      "String1",
      "String2",
      "String3",
      "String4"
   ]
}
EOF
	conf="scope=given"
	cat <<EOF | zexe given_only.zen myNestedRepetitveObject.json
Given I have a 'string dictionary' named 'myDictionary'
and I have a 'string array' named 'myArray'

Given I have a 'string dictionary' named 'missingDictionary'
and I have a 'base64 dictionary' named 'missingArray'

Then print codec
EOF
	save_output given_schema_missing.json
	assert_output '{"CODEC":{"missingArray":{"encoding":"base64","missing":true,"name":"missingArray","zentype":"d"},"missingDictionary":{"encoding":"string","missing":true,"name":"missingDictionary","zentype":"d"},"myArray":{"encoding":"string","name":"myArray","zentype":"a"},"myDictionary":{"encoding":"string","name":"myDictionary","zentype":"d"}}}'
}

@test "Zencode scope=given with missing schema type" {

    cat <<EOF | save_asset 'eth_addr.json'
{
	"ethereum_address": "0x380FfB13F42AfFBE88949643B27FA74Ba85B3977",
    "keyring": {
        "ethereum": "876f6d4554e91f6f4bdaf8c741eef18b28f580f01d9d1af43c5238b8fe6bac6b"
    }
}
EOF
	conf="scope=given"
	cat <<EOF | zexe given_only.zen eth_addr.json
Scenario ethereum

Given I have a 'ethereum address'
and I have an 'ethereum address' named 'missing address'

and I have a 'keyring'

Then print codec
EOF
	save_output given_schema_missing.json
	assert_output '{"CODEC":{"ethereum_address":{"bintype":"zenroom.octet","encoding":"complex","name":"ethereum_address","schema":"ethereum_address","zentype":"e"},"keyring":{"encoding":"complex","name":"keyring","schema":"keyring","zentype":"e"},"missing_address":{"encoding":"complex","missing":true,"name":"missing_address","schema":"ethereum_address","zentype":"e"}}}'


# TODO: missing keyring
#       missing own data with declared owner 'Alice'
}

@test "Zencode scope=given with missing inside object" {
    cat <<EOF | save myNestedRepetitveObject.json
{
   "myFirstObject":{
      "myNumber":11223344,
      "myString":"Hello World!",
      "myStringArray":[
         "String1",
         "String2",
         "String3",
         "String4"
      ]
   },
    "Alice":{
		  "keyring":{
			 "ecdh":"AxLMXkey00i2BD675vpMQ8WhP/CwEfmdRr+BtpuJ2rM="
		  }
	   }
}
EOF
	conf="scope=given"
	cat <<EOF | zexe given_only.zen myNestedRepetitveObject.json
Given I am 'Alice'
and I have my 'hex' named 'missing public key'
Given I have a 'string array' named 'myStringArray' in 'myFirstObject'
And I have a 'string dictionary' named 'does not exists' in 'myFirstObject'
When I create the random 'random'
Then print codec
EOF
	save_output given_schema_missing.json
	assert_output '{"CODEC":{"does_not_exists":{"encoding":"string","missing":true,"name":"does_not_exists","root":"myFirstObject","zentype":"d"},"missing_public_key":{"encoding":"hex","missing":true,"name":"missing_public_key","root":"Alice","zentype":"e"},"myStringArray":{"encoding":"string","name":"myStringArray","root":"myFirstObject","zentype":"a"}}}'

}

@test "Zencode scope=given with statements that starts with and" {
	conf="scope=given"
	cat <<EOF | zexe given_with_and.zen
Given I have a 'hex' named 'missing public key'
and I have a 'string dictionary' named 'does not exists'
When I create the random 'random'
and I create the 'string dictioanry' named 'hello'

Then print codec
and print 'hello'
EOF
	save_output given_with_and.json
	assert_output '{"CODEC":{"does_not_exists":{"encoding":"string","missing":true,"name":"does_not_exists","zentype":"d"},"missing_public_key":{"encoding":"hex","missing":true,"name":"missing_public_key","zentype":"e"}}}'
}
