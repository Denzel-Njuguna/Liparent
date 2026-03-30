defmodule LiparentV1.Validation do
  use Ecto.Schema
  import Ecto.Changeset

  # Validate Kenyan phone numbers
  def validate_phone(changeset, field) do
    validate_change(changeset, field, fn _, phone ->
      valid = String.match?(phone, ~r/^07[0-9]{8}$/) or
              String.match?(phone, ~r/^01[0-9]{8}$/) or
              String.match?(phone, ~r/^2547[0-9]{8}$/) or
              String.match?(phone, ~r/^2541[0-9]{8}$/)

      if valid do
        []
      else
        [{field, "must be a valid Kenyan phone number (e.g., 0712345678 or 254712345678)"}]
      end
    end)
  end

  # Validate UUID format
  def validate_uuid(changeset, field) do
    validate_change(changeset, field, fn _, value ->
      case Ecto.UUID.cast(value) do
        {:ok, _uuid} -> []
        :error -> [{field, "must be a valid UUID (e.g., 550e8400-e29b-41d4-a716-446655440000)"}]
      end
    end)
  end

  # Validate password strength
  def validate_password_strength(changeset, field) do
    password = get_field(changeset, field)

    # Skip if no password
    if is_nil(password) do
      changeset
    else
      changeset
      |> validate_length(field, min: 8, max: 72,
          message: "must be between 8 and 72 characters")
      |> validate_format(field, ~r/[A-Z]/,
          message: "must contain at least one uppercase letter")
      |> validate_format(field, ~r/[a-z]/,
          message: "must contain at least one lowercase letter")
      |> validate_format(field, ~r/[0-9]/,
          message: "must contain at least one number")
      |> validate_format(field, ~r/[!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]/,
          message: "must contain at least one special character")
      |> validate_common_password(field)
    end
  end

  # Check for common passwords
  defp validate_common_password(changeset, field) do
    password = get_field(changeset, field)
    common_passwords = ["password123", "admin123", "12345678", "Password123!", "qwerty123"]

    if password in common_passwords do
      add_error(changeset, field, "is too common, please choose a stronger password")
    else
      changeset
    end
  end

  # Validate format for various fields
  def validate_format_fields(changeset) do
    changeset
    |> validate_format(:fullname, ~r/^[A-Za-z\s]+$/,
        message: "must contain only letters and spaces")
    |> validate_format(:buildingname, ~r/^[A-Za-z0-9\s\-]+$/,
        message: "must contain only letters, numbers, spaces, and hyphens")
    |> validate_format(:houseno, ~r/^[A-Za-z0-9\-]+$/,
        message: "must contain only letters, numbers, and hyphens")
  end
  def validate_string_name(changeset, field) do
        changeset
        |>validate_format(field,  ~r/^[A-Za-z0-9\-]+$/,
      message: "must contain only letters, number and hyphens")
  end
  # Validate email format
  def validate_email(changeset, field) do
    validate_format(changeset, field, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/,
        message: "must be a valid email address")
  end

  #Validate required fields with custom message
  def validate_required_custom(changeset, fields, message \\ "cannot be empty") do
    validate_required(changeset, fields, message: message)
  end
end
