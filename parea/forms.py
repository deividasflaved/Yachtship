"""Create your forms here."""

from django.contrib.auth import get_user_model
from django.contrib.auth.forms import UserCreationForm

USERMODEL = get_user_model()


class RegisterForm(UserCreationForm):
    """Custom registration form"""

    class Meta:
        model = USERMODEL
        fields = ('first_name', 'email', 'username')
