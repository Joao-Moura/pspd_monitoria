# -*- coding: utf-8 -*-
# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: minmax.proto
"""Generated protocol buffer code."""
from google.protobuf import descriptor as _descriptor
from google.protobuf import descriptor_pool as _descriptor_pool
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor_pool.Default().AddSerializedFile(b'\n\x0cminmax.proto\"\x1e\n\x0b\x46indRequest\x12\x0f\n\x07numbers\x18\x01 \x03(\x02\"(\n\x0c\x46indResponse\x12\x0b\n\x03min\x18\x01 \x01(\x02\x12\x0b\n\x03max\x18\x02 \x01(\x02\x32/\n\x06MinMax\x12%\n\x04\x46ind\x12\x0c.FindRequest\x1a\r.FindResponse\"\x00\x62\x06proto3')



_FINDREQUEST = DESCRIPTOR.message_types_by_name['FindRequest']
_FINDRESPONSE = DESCRIPTOR.message_types_by_name['FindResponse']
FindRequest = _reflection.GeneratedProtocolMessageType('FindRequest', (_message.Message,), {
  'DESCRIPTOR' : _FINDREQUEST,
  '__module__' : 'minmax_pb2'
  # @@protoc_insertion_point(class_scope:FindRequest)
  })
_sym_db.RegisterMessage(FindRequest)

FindResponse = _reflection.GeneratedProtocolMessageType('FindResponse', (_message.Message,), {
  'DESCRIPTOR' : _FINDRESPONSE,
  '__module__' : 'minmax_pb2'
  # @@protoc_insertion_point(class_scope:FindResponse)
  })
_sym_db.RegisterMessage(FindResponse)

_MINMAX = DESCRIPTOR.services_by_name['MinMax']
if _descriptor._USE_C_DESCRIPTORS == False:

  DESCRIPTOR._options = None
  _FINDREQUEST._serialized_start=16
  _FINDREQUEST._serialized_end=46
  _FINDRESPONSE._serialized_start=48
  _FINDRESPONSE._serialized_end=88
  _MINMAX._serialized_start=90
  _MINMAX._serialized_end=137
# @@protoc_insertion_point(module_scope)
