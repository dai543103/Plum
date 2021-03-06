// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: battlespheres_login.proto

#ifndef PROTOBUF_battlespheres_5flogin_2eproto__INCLUDED
#define PROTOBUF_battlespheres_5flogin_2eproto__INCLUDED

#include <string>

#include <google/protobuf/stubs/common.h>

#if GOOGLE_PROTOBUF_VERSION < 3003000
#error This file was generated by a newer version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please update
#error your headers.
#endif
#if 3003001 < GOOGLE_PROTOBUF_MIN_PROTOC_VERSION
#error This file was generated by an older version of protoc which is
#error incompatible with your Protocol Buffer headers.  Please
#error regenerate this file with a newer version of protoc.
#endif

#include <google/protobuf/io/coded_stream.h>
#include <google/protobuf/arena.h>
#include <google/protobuf/arenastring.h>
#include <google/protobuf/generated_message_table_driven.h>
#include <google/protobuf/generated_message_util.h>
#include <google/protobuf/metadata.h>
#include <google/protobuf/message.h>
#include <google/protobuf/repeated_field.h>  // IWYU pragma: export
#include <google/protobuf/extension_set.h>  // IWYU pragma: export
#include <google/protobuf/generated_enum_reflection.h>
#include <google/protobuf/unknown_field_set.h>
// @@protoc_insertion_point(includes)
namespace battlespheresproto_login {
class APPAccountInfo;
class APPAccountInfoDefaultTypeInternal;
extern APPAccountInfoDefaultTypeInternal _APPAccountInfo_default_instance_;
class AccountInfo;
class AccountInfoDefaultTypeInternal;
extern AccountInfoDefaultTypeInternal _AccountInfo_default_instance_;
class LoginKeyInfo;
class LoginKeyInfoDefaultTypeInternal;
extern LoginKeyInfoDefaultTypeInternal _LoginKeyInfo_default_instance_;
}  // namespace battlespheresproto_login

namespace battlespheresproto_login {

namespace protobuf_battlespheres_5flogin_2eproto {
// Internal implementation detail -- do not call these.
struct TableStruct {
  static const ::google::protobuf::internal::ParseTableField entries[];
  static const ::google::protobuf::internal::AuxillaryParseTableField aux[];
  static const ::google::protobuf::internal::ParseTable schema[];
  static const ::google::protobuf::uint32 offsets[];
  static void InitDefaultsImpl();
  static void Shutdown();
};
void AddDescriptors();
void InitDefaults();
}  // namespace protobuf_battlespheres_5flogin_2eproto

enum msgId {
  unused = 0,
  cmdVerifyReq = 200,
  cmdVerifyRsp = 201,
  cmdRegistReq = 202,
  cmdRegistRsp = 203,
  cmdAPPVerifyReq = 204,
  cmdAPPRegistReq = 205,
  msgId_INT_MIN_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32min,
  msgId_INT_MAX_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32max
};
bool msgId_IsValid(int value);
const msgId msgId_MIN = unused;
const msgId msgId_MAX = cmdAPPRegistReq;
const int msgId_ARRAYSIZE = msgId_MAX + 1;

const ::google::protobuf::EnumDescriptor* msgId_descriptor();
inline const ::std::string& msgId_Name(msgId value) {
  return ::google::protobuf::internal::NameOfEnum(
    msgId_descriptor(), value);
}
inline bool msgId_Parse(
    const ::std::string& name, msgId* value) {
  return ::google::protobuf::internal::ParseNamedEnum<msgId>(
    msgId_descriptor(), name, value);
}
enum error_code {
  success = 0,
  server_is_busy = 1,
  need_to_create_a_role = 2,
  account_already_exists = 100,
  account_or_password_error = 101,
  token_verify_error = 102,
  token_verify_expired = 103,
  role_id_non_existed = 200,
  nick_name_too_long = 201,
  nick_name_existing_keyword = 202,
  error_code_INT_MIN_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32min,
  error_code_INT_MAX_SENTINEL_DO_NOT_USE_ = ::google::protobuf::kint32max
};
bool error_code_IsValid(int value);
const error_code error_code_MIN = success;
const error_code error_code_MAX = nick_name_existing_keyword;
const int error_code_ARRAYSIZE = error_code_MAX + 1;

const ::google::protobuf::EnumDescriptor* error_code_descriptor();
inline const ::std::string& error_code_Name(error_code value) {
  return ::google::protobuf::internal::NameOfEnum(
    error_code_descriptor(), value);
}
inline bool error_code_Parse(
    const ::std::string& name, error_code* value) {
  return ::google::protobuf::internal::ParseNamedEnum<error_code>(
    error_code_descriptor(), name, value);
}
// ===================================================================

class AccountInfo : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:battlespheresproto_login.AccountInfo) */ {
 public:
  AccountInfo();
  virtual ~AccountInfo();

  AccountInfo(const AccountInfo& from);

  inline AccountInfo& operator=(const AccountInfo& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const AccountInfo& default_instance();

  static inline const AccountInfo* internal_default_instance() {
    return reinterpret_cast<const AccountInfo*>(
               &_AccountInfo_default_instance_);
  }
  static PROTOBUF_CONSTEXPR int const kIndexInFileMessages =
    0;

  void Swap(AccountInfo* other);

  // implements Message ----------------------------------------------

  inline AccountInfo* New() const PROTOBUF_FINAL { return New(NULL); }

  AccountInfo* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const AccountInfo& from);
  void MergeFrom(const AccountInfo& from);
  void Clear() PROTOBUF_FINAL;
  bool IsInitialized() const PROTOBUF_FINAL;

  size_t ByteSizeLong() const PROTOBUF_FINAL;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input) PROTOBUF_FINAL;
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const PROTOBUF_FINAL;
  ::google::protobuf::uint8* InternalSerializeWithCachedSizesToArray(
      bool deterministic, ::google::protobuf::uint8* target) const PROTOBUF_FINAL;
  int GetCachedSize() const PROTOBUF_FINAL { return _cached_size_; }
  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const PROTOBUF_FINAL;
  void InternalSwap(AccountInfo* other);
  private:
  inline ::google::protobuf::Arena* GetArenaNoVirtual() const {
    return NULL;
  }
  inline void* MaybeArenaPtr() const {
    return NULL;
  }
  public:

  ::google::protobuf::Metadata GetMetadata() const PROTOBUF_FINAL;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // bytes acctname = 1;
  void clear_acctname();
  static const int kAcctnameFieldNumber = 1;
  const ::std::string& acctname() const;
  void set_acctname(const ::std::string& value);
  #if LANG_CXX11
  void set_acctname(::std::string&& value);
  #endif
  void set_acctname(const char* value);
  void set_acctname(const void* value, size_t size);
  ::std::string* mutable_acctname();
  ::std::string* release_acctname();
  void set_allocated_acctname(::std::string* acctname);

  // bytes password = 2;
  void clear_password();
  static const int kPasswordFieldNumber = 2;
  const ::std::string& password() const;
  void set_password(const ::std::string& value);
  #if LANG_CXX11
  void set_password(::std::string&& value);
  #endif
  void set_password(const char* value);
  void set_password(const void* value, size_t size);
  ::std::string* mutable_password();
  ::std::string* release_password();
  void set_allocated_password(::std::string* password);

  // @@protoc_insertion_point(class_scope:battlespheresproto_login.AccountInfo)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::internal::ArenaStringPtr acctname_;
  ::google::protobuf::internal::ArenaStringPtr password_;
  mutable int _cached_size_;
  friend struct protobuf_battlespheres_5flogin_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class LoginKeyInfo : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:battlespheresproto_login.LoginKeyInfo) */ {
 public:
  LoginKeyInfo();
  virtual ~LoginKeyInfo();

  LoginKeyInfo(const LoginKeyInfo& from);

  inline LoginKeyInfo& operator=(const LoginKeyInfo& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const LoginKeyInfo& default_instance();

  static inline const LoginKeyInfo* internal_default_instance() {
    return reinterpret_cast<const LoginKeyInfo*>(
               &_LoginKeyInfo_default_instance_);
  }
  static PROTOBUF_CONSTEXPR int const kIndexInFileMessages =
    1;

  void Swap(LoginKeyInfo* other);

  // implements Message ----------------------------------------------

  inline LoginKeyInfo* New() const PROTOBUF_FINAL { return New(NULL); }

  LoginKeyInfo* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const LoginKeyInfo& from);
  void MergeFrom(const LoginKeyInfo& from);
  void Clear() PROTOBUF_FINAL;
  bool IsInitialized() const PROTOBUF_FINAL;

  size_t ByteSizeLong() const PROTOBUF_FINAL;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input) PROTOBUF_FINAL;
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const PROTOBUF_FINAL;
  ::google::protobuf::uint8* InternalSerializeWithCachedSizesToArray(
      bool deterministic, ::google::protobuf::uint8* target) const PROTOBUF_FINAL;
  int GetCachedSize() const PROTOBUF_FINAL { return _cached_size_; }
  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const PROTOBUF_FINAL;
  void InternalSwap(LoginKeyInfo* other);
  private:
  inline ::google::protobuf::Arena* GetArenaNoVirtual() const {
    return NULL;
  }
  inline void* MaybeArenaPtr() const {
    return NULL;
  }
  public:

  ::google::protobuf::Metadata GetMetadata() const PROTOBUF_FINAL;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // bytes loginaddr = 2;
  void clear_loginaddr();
  static const int kLoginaddrFieldNumber = 2;
  const ::std::string& loginaddr() const;
  void set_loginaddr(const ::std::string& value);
  #if LANG_CXX11
  void set_loginaddr(::std::string&& value);
  #endif
  void set_loginaddr(const char* value);
  void set_loginaddr(const void* value, size_t size);
  ::std::string* mutable_loginaddr();
  ::std::string* release_loginaddr();
  void set_allocated_loginaddr(::std::string* loginaddr);

  // bytes token = 4;
  void clear_token();
  static const int kTokenFieldNumber = 4;
  const ::std::string& token() const;
  void set_token(const ::std::string& value);
  #if LANG_CXX11
  void set_token(::std::string&& value);
  #endif
  void set_token(const char* value);
  void set_token(const void* value, size_t size);
  ::std::string* mutable_token();
  ::std::string* release_token();
  void set_allocated_token(::std::string* token);

  // int32 result = 1;
  void clear_result();
  static const int kResultFieldNumber = 1;
  ::google::protobuf::int32 result() const;
  void set_result(::google::protobuf::int32 value);

  // int32 loginPort = 3;
  void clear_loginport();
  static const int kLoginPortFieldNumber = 3;
  ::google::protobuf::int32 loginport() const;
  void set_loginport(::google::protobuf::int32 value);

  // @@protoc_insertion_point(class_scope:battlespheresproto_login.LoginKeyInfo)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::internal::ArenaStringPtr loginaddr_;
  ::google::protobuf::internal::ArenaStringPtr token_;
  ::google::protobuf::int32 result_;
  ::google::protobuf::int32 loginport_;
  mutable int _cached_size_;
  friend struct protobuf_battlespheres_5flogin_2eproto::TableStruct;
};
// -------------------------------------------------------------------

class APPAccountInfo : public ::google::protobuf::Message /* @@protoc_insertion_point(class_definition:battlespheresproto_login.APPAccountInfo) */ {
 public:
  APPAccountInfo();
  virtual ~APPAccountInfo();

  APPAccountInfo(const APPAccountInfo& from);

  inline APPAccountInfo& operator=(const APPAccountInfo& from) {
    CopyFrom(from);
    return *this;
  }

  static const ::google::protobuf::Descriptor* descriptor();
  static const APPAccountInfo& default_instance();

  static inline const APPAccountInfo* internal_default_instance() {
    return reinterpret_cast<const APPAccountInfo*>(
               &_APPAccountInfo_default_instance_);
  }
  static PROTOBUF_CONSTEXPR int const kIndexInFileMessages =
    2;

  void Swap(APPAccountInfo* other);

  // implements Message ----------------------------------------------

  inline APPAccountInfo* New() const PROTOBUF_FINAL { return New(NULL); }

  APPAccountInfo* New(::google::protobuf::Arena* arena) const PROTOBUF_FINAL;
  void CopyFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void MergeFrom(const ::google::protobuf::Message& from) PROTOBUF_FINAL;
  void CopyFrom(const APPAccountInfo& from);
  void MergeFrom(const APPAccountInfo& from);
  void Clear() PROTOBUF_FINAL;
  bool IsInitialized() const PROTOBUF_FINAL;

  size_t ByteSizeLong() const PROTOBUF_FINAL;
  bool MergePartialFromCodedStream(
      ::google::protobuf::io::CodedInputStream* input) PROTOBUF_FINAL;
  void SerializeWithCachedSizes(
      ::google::protobuf::io::CodedOutputStream* output) const PROTOBUF_FINAL;
  ::google::protobuf::uint8* InternalSerializeWithCachedSizesToArray(
      bool deterministic, ::google::protobuf::uint8* target) const PROTOBUF_FINAL;
  int GetCachedSize() const PROTOBUF_FINAL { return _cached_size_; }
  private:
  void SharedCtor();
  void SharedDtor();
  void SetCachedSize(int size) const PROTOBUF_FINAL;
  void InternalSwap(APPAccountInfo* other);
  private:
  inline ::google::protobuf::Arena* GetArenaNoVirtual() const {
    return NULL;
  }
  inline void* MaybeArenaPtr() const {
    return NULL;
  }
  public:

  ::google::protobuf::Metadata GetMetadata() const PROTOBUF_FINAL;

  // nested types ----------------------------------------------------

  // accessors -------------------------------------------------------

  // int32 appid = 1;
  void clear_appid();
  static const int kAppidFieldNumber = 1;
  ::google::protobuf::int32 appid() const;
  void set_appid(::google::protobuf::int32 value);

  // @@protoc_insertion_point(class_scope:battlespheresproto_login.APPAccountInfo)
 private:

  ::google::protobuf::internal::InternalMetadataWithArena _internal_metadata_;
  ::google::protobuf::int32 appid_;
  mutable int _cached_size_;
  friend struct protobuf_battlespheres_5flogin_2eproto::TableStruct;
};
// ===================================================================


// ===================================================================

#if !PROTOBUF_INLINE_NOT_IN_HEADERS
// AccountInfo

// bytes acctname = 1;
inline void AccountInfo::clear_acctname() {
  acctname_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline const ::std::string& AccountInfo::acctname() const {
  // @@protoc_insertion_point(field_get:battlespheresproto_login.AccountInfo.acctname)
  return acctname_.GetNoArena();
}
inline void AccountInfo::set_acctname(const ::std::string& value) {
  
  acctname_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value);
  // @@protoc_insertion_point(field_set:battlespheresproto_login.AccountInfo.acctname)
}
#if LANG_CXX11
inline void AccountInfo::set_acctname(::std::string&& value) {
  
  acctname_.SetNoArena(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value));
  // @@protoc_insertion_point(field_set_rvalue:battlespheresproto_login.AccountInfo.acctname)
}
#endif
inline void AccountInfo::set_acctname(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  
  acctname_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value));
  // @@protoc_insertion_point(field_set_char:battlespheresproto_login.AccountInfo.acctname)
}
inline void AccountInfo::set_acctname(const void* value, size_t size) {
  
  acctname_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      ::std::string(reinterpret_cast<const char*>(value), size));
  // @@protoc_insertion_point(field_set_pointer:battlespheresproto_login.AccountInfo.acctname)
}
inline ::std::string* AccountInfo::mutable_acctname() {
  
  // @@protoc_insertion_point(field_mutable:battlespheresproto_login.AccountInfo.acctname)
  return acctname_.MutableNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline ::std::string* AccountInfo::release_acctname() {
  // @@protoc_insertion_point(field_release:battlespheresproto_login.AccountInfo.acctname)
  
  return acctname_.ReleaseNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline void AccountInfo::set_allocated_acctname(::std::string* acctname) {
  if (acctname != NULL) {
    
  } else {
    
  }
  acctname_.SetAllocatedNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), acctname);
  // @@protoc_insertion_point(field_set_allocated:battlespheresproto_login.AccountInfo.acctname)
}

// bytes password = 2;
inline void AccountInfo::clear_password() {
  password_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline const ::std::string& AccountInfo::password() const {
  // @@protoc_insertion_point(field_get:battlespheresproto_login.AccountInfo.password)
  return password_.GetNoArena();
}
inline void AccountInfo::set_password(const ::std::string& value) {
  
  password_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value);
  // @@protoc_insertion_point(field_set:battlespheresproto_login.AccountInfo.password)
}
#if LANG_CXX11
inline void AccountInfo::set_password(::std::string&& value) {
  
  password_.SetNoArena(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value));
  // @@protoc_insertion_point(field_set_rvalue:battlespheresproto_login.AccountInfo.password)
}
#endif
inline void AccountInfo::set_password(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  
  password_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value));
  // @@protoc_insertion_point(field_set_char:battlespheresproto_login.AccountInfo.password)
}
inline void AccountInfo::set_password(const void* value, size_t size) {
  
  password_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      ::std::string(reinterpret_cast<const char*>(value), size));
  // @@protoc_insertion_point(field_set_pointer:battlespheresproto_login.AccountInfo.password)
}
inline ::std::string* AccountInfo::mutable_password() {
  
  // @@protoc_insertion_point(field_mutable:battlespheresproto_login.AccountInfo.password)
  return password_.MutableNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline ::std::string* AccountInfo::release_password() {
  // @@protoc_insertion_point(field_release:battlespheresproto_login.AccountInfo.password)
  
  return password_.ReleaseNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline void AccountInfo::set_allocated_password(::std::string* password) {
  if (password != NULL) {
    
  } else {
    
  }
  password_.SetAllocatedNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), password);
  // @@protoc_insertion_point(field_set_allocated:battlespheresproto_login.AccountInfo.password)
}

// -------------------------------------------------------------------

// LoginKeyInfo

// int32 result = 1;
inline void LoginKeyInfo::clear_result() {
  result_ = 0;
}
inline ::google::protobuf::int32 LoginKeyInfo::result() const {
  // @@protoc_insertion_point(field_get:battlespheresproto_login.LoginKeyInfo.result)
  return result_;
}
inline void LoginKeyInfo::set_result(::google::protobuf::int32 value) {
  
  result_ = value;
  // @@protoc_insertion_point(field_set:battlespheresproto_login.LoginKeyInfo.result)
}

// bytes loginaddr = 2;
inline void LoginKeyInfo::clear_loginaddr() {
  loginaddr_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline const ::std::string& LoginKeyInfo::loginaddr() const {
  // @@protoc_insertion_point(field_get:battlespheresproto_login.LoginKeyInfo.loginaddr)
  return loginaddr_.GetNoArena();
}
inline void LoginKeyInfo::set_loginaddr(const ::std::string& value) {
  
  loginaddr_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value);
  // @@protoc_insertion_point(field_set:battlespheresproto_login.LoginKeyInfo.loginaddr)
}
#if LANG_CXX11
inline void LoginKeyInfo::set_loginaddr(::std::string&& value) {
  
  loginaddr_.SetNoArena(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value));
  // @@protoc_insertion_point(field_set_rvalue:battlespheresproto_login.LoginKeyInfo.loginaddr)
}
#endif
inline void LoginKeyInfo::set_loginaddr(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  
  loginaddr_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value));
  // @@protoc_insertion_point(field_set_char:battlespheresproto_login.LoginKeyInfo.loginaddr)
}
inline void LoginKeyInfo::set_loginaddr(const void* value, size_t size) {
  
  loginaddr_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      ::std::string(reinterpret_cast<const char*>(value), size));
  // @@protoc_insertion_point(field_set_pointer:battlespheresproto_login.LoginKeyInfo.loginaddr)
}
inline ::std::string* LoginKeyInfo::mutable_loginaddr() {
  
  // @@protoc_insertion_point(field_mutable:battlespheresproto_login.LoginKeyInfo.loginaddr)
  return loginaddr_.MutableNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline ::std::string* LoginKeyInfo::release_loginaddr() {
  // @@protoc_insertion_point(field_release:battlespheresproto_login.LoginKeyInfo.loginaddr)
  
  return loginaddr_.ReleaseNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline void LoginKeyInfo::set_allocated_loginaddr(::std::string* loginaddr) {
  if (loginaddr != NULL) {
    
  } else {
    
  }
  loginaddr_.SetAllocatedNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), loginaddr);
  // @@protoc_insertion_point(field_set_allocated:battlespheresproto_login.LoginKeyInfo.loginaddr)
}

// int32 loginPort = 3;
inline void LoginKeyInfo::clear_loginport() {
  loginport_ = 0;
}
inline ::google::protobuf::int32 LoginKeyInfo::loginport() const {
  // @@protoc_insertion_point(field_get:battlespheresproto_login.LoginKeyInfo.loginPort)
  return loginport_;
}
inline void LoginKeyInfo::set_loginport(::google::protobuf::int32 value) {
  
  loginport_ = value;
  // @@protoc_insertion_point(field_set:battlespheresproto_login.LoginKeyInfo.loginPort)
}

// bytes token = 4;
inline void LoginKeyInfo::clear_token() {
  token_.ClearToEmptyNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline const ::std::string& LoginKeyInfo::token() const {
  // @@protoc_insertion_point(field_get:battlespheresproto_login.LoginKeyInfo.token)
  return token_.GetNoArena();
}
inline void LoginKeyInfo::set_token(const ::std::string& value) {
  
  token_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), value);
  // @@protoc_insertion_point(field_set:battlespheresproto_login.LoginKeyInfo.token)
}
#if LANG_CXX11
inline void LoginKeyInfo::set_token(::std::string&& value) {
  
  token_.SetNoArena(
    &::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::move(value));
  // @@protoc_insertion_point(field_set_rvalue:battlespheresproto_login.LoginKeyInfo.token)
}
#endif
inline void LoginKeyInfo::set_token(const char* value) {
  GOOGLE_DCHECK(value != NULL);
  
  token_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), ::std::string(value));
  // @@protoc_insertion_point(field_set_char:battlespheresproto_login.LoginKeyInfo.token)
}
inline void LoginKeyInfo::set_token(const void* value, size_t size) {
  
  token_.SetNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(),
      ::std::string(reinterpret_cast<const char*>(value), size));
  // @@protoc_insertion_point(field_set_pointer:battlespheresproto_login.LoginKeyInfo.token)
}
inline ::std::string* LoginKeyInfo::mutable_token() {
  
  // @@protoc_insertion_point(field_mutable:battlespheresproto_login.LoginKeyInfo.token)
  return token_.MutableNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline ::std::string* LoginKeyInfo::release_token() {
  // @@protoc_insertion_point(field_release:battlespheresproto_login.LoginKeyInfo.token)
  
  return token_.ReleaseNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited());
}
inline void LoginKeyInfo::set_allocated_token(::std::string* token) {
  if (token != NULL) {
    
  } else {
    
  }
  token_.SetAllocatedNoArena(&::google::protobuf::internal::GetEmptyStringAlreadyInited(), token);
  // @@protoc_insertion_point(field_set_allocated:battlespheresproto_login.LoginKeyInfo.token)
}

// -------------------------------------------------------------------

// APPAccountInfo

// int32 appid = 1;
inline void APPAccountInfo::clear_appid() {
  appid_ = 0;
}
inline ::google::protobuf::int32 APPAccountInfo::appid() const {
  // @@protoc_insertion_point(field_get:battlespheresproto_login.APPAccountInfo.appid)
  return appid_;
}
inline void APPAccountInfo::set_appid(::google::protobuf::int32 value) {
  
  appid_ = value;
  // @@protoc_insertion_point(field_set:battlespheresproto_login.APPAccountInfo.appid)
}

#endif  // !PROTOBUF_INLINE_NOT_IN_HEADERS
// -------------------------------------------------------------------

// -------------------------------------------------------------------


// @@protoc_insertion_point(namespace_scope)


}  // namespace battlespheresproto_login

#ifndef SWIG
namespace google {
namespace protobuf {

template <> struct is_proto_enum< ::battlespheresproto_login::msgId> : ::google::protobuf::internal::true_type {};
template <>
inline const EnumDescriptor* GetEnumDescriptor< ::battlespheresproto_login::msgId>() {
  return ::battlespheresproto_login::msgId_descriptor();
}
template <> struct is_proto_enum< ::battlespheresproto_login::error_code> : ::google::protobuf::internal::true_type {};
template <>
inline const EnumDescriptor* GetEnumDescriptor< ::battlespheresproto_login::error_code>() {
  return ::battlespheresproto_login::error_code_descriptor();
}

}  // namespace protobuf
}  // namespace google
#endif  // SWIG

// @@protoc_insertion_point(global_scope)

#endif  // PROTOBUF_battlespheres_5flogin_2eproto__INCLUDED
