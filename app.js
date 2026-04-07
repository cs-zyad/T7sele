// ════════ NAVIGATION ════════
function goTo(screenId) {
  var pages = {
    'splash': 'index.html',
    'login': 'login.html',
    'onboarding': 'onboarding.html',
    'paywall': 'paywall.html',
    'home': 'home.html',
    'session': 'session.html',
    'result': 'result.html',
    'settings': 'settings.html',
    'progress': 'progress.html',
    'progress-screen': 'progress.html',
    'coming': 'coming-soon.html',
    'coming-soon': 'coming-soon.html'
  };
  if (pages[screenId]) location.href = pages[screenId];
}
window.goTo = goTo;

// ════════ LOGIN ════════
function handleLogin() {
  var form = document.querySelector('.login-form');
  if (!form) { goTo('home'); return; }

  var emailInput = form.querySelector('input[type="email"]');
  var passInput  = form.querySelector('input[type="password"]');
  if (!emailInput || !passInput) return;

  var email = emailInput.value.trim();
  var pass  = passInput.value.trim();

  if (!email || !pass) {
    alert('\u064a\u0631\u062c\u0649 \u0625\u062f\u062e\u0627\u0644 \u0627\u0644\u0628\u064a\u0627\u0646\u0627\u062a');
    return;
  }

  if (email === 'premium@t7sele.com' && pass === '123456') {
    localStorage.setItem('isSubscriber', 'true');
    localStorage.setItem('userName', '\u0623\u062d\u0645\u062f \u0627\u0644\u063a\u0627\u0645\u062f\u064a');
    localStorage.setItem('userAvatar', '\u0623\u062d');
    goTo('home');
  } else if (email === 'trial@t7sele.com' && pass === '123456') {
    localStorage.setItem('isSubscriber', 'false');
    localStorage.setItem('userName', '\u0645\u0633\u062a\u062e\u062f\u0645 \u062a\u062c\u0631\u064a\u0628\u064a');
    localStorage.setItem('userAvatar', '\u0645\u062c');
    goTo('home');
  } else {
    alert('\u0628\u064a\u0627\u0646\u0627\u062a \u062e\u0627\u0637\u0626\u0629.\n\u062c\u0631\u0628:\n- premium@t7sele.com / 123456\n- trial@t7sele.com / 123456');
  }
}
window.handleLogin = handleLogin;

function logout() {
  localStorage.clear();
  location.href = 'index.html';
}
window.logout = logout;

// ════════ SUBSCRIPTION ════════
function checkSubscription() {
  return localStorage.getItem('isSubscriber') === 'true';
}
var isSubscriber = checkSubscription();

function updateProfileUI() {
  var name   = localStorage.getItem('userName')   || 'مستخدم جديد';
  var avatar = localStorage.getItem('userAvatar') || 'م';

  var nameEl        = document.getElementById('home-name');
  var avatarEl      = document.getElementById('home-avatar');
  var settingsNameEl = document.getElementById('settings-profile-name');

  if (nameEl)        nameEl.textContent        = name;
  if (avatarEl)      avatarEl.textContent      = avatar;
  if (settingsNameEl) settingsNameEl.textContent = name;
}

function updateSubscriptionUI() {
  isSubscriber = checkSubscription();

  var premiumElements = document.querySelectorAll('.subscriber-only');
  var subCards        = document.querySelectorAll('.sub-card');
  var premiumSubjects = document.querySelectorAll('.premium-subject');
  var premiumRows     = document.querySelectorAll('.settings-row.premium-feature');

  premiumElements.forEach(function(el) {
    if (isSubscriber) el.classList.remove('premium-hidden');
    else              el.classList.add('premium-hidden');
  });

  subCards.forEach(function(card) {
    card.style.display = isSubscriber ? 'block' : 'none';
  });

  premiumSubjects.forEach(function(el) {
    if (isSubscriber) el.classList.remove('locked');
    else              el.classList.add('locked');
  });

  premiumRows.forEach(function(row) {
    if (isSubscriber) row.classList.remove('locked');
    else              row.classList.add('locked');
  });
}

function handlePremiumRowClick(event) {
  if (!isSubscriber) {
    event.stopPropagation();
    event.preventDefault();
    alert('هذه الإعدادات متاحة للمشتركين فقط 💎');
    goTo('paywall');
  }
}
window.handlePremiumRowClick = handlePremiumRowClick;

// ════════ SESSION ════════
function startSession(subject) {
  if (subject !== 'math' && !isSubscriber) {
    alert('هذه المادة متاحة للمشتركين فقط 💎');
    goTo('paywall');
    return;
  }
  localStorage.setItem('currentSubject', subject);
  goTo('result');
}
window.startSession = startSession;

// ════════ COUNTDOWN ════════
function updateDays(dateValue) {
  var resultEl   = document.getElementById('days-result');
  var homeDaysEl = document.getElementById('home-days');
  var homeDateEl = document.getElementById('home-date');
  if (!dateValue) return;

  localStorage.setItem('selectedExamDate', dateValue);

  var targetDate = new Date(dateValue);
  var today = new Date();
  today.setHours(0, 0, 0, 0);

  var diffDays = Math.ceil((targetDate - today) / (1000 * 60 * 60 * 24));
  var isPast   = diffDays < 0;

  var display = isPast
    ? '\u062a\u0627\u0631\u064a\u062e \u0633\u0627\u0628\u0642! \u26a0\ufe0f'
    : diffDays.toLocaleString('ar-SA') + ' \u064a\u0648\u0645 \u0645\u062a\u0628\u0642\u064a\u0629';

  if (resultEl)   resultEl.textContent   = display;
  if (homeDaysEl) homeDaysEl.textContent = isPast ? '\u0660' : diffDays.toLocaleString('ar-SA');
  if (homeDateEl) homeDateEl.textContent = targetDate.toLocaleDateString('ar-SA', { day: 'numeric', month: 'long', year: 'numeric' });
}
window.updateDays = updateDays;

function initHomeCountdown() {
  var saved = localStorage.getItem('selectedExamDate') || '2026-06-15';
  updateDays(saved);
}

// ════════ ONBOARDING ════════
var obCurrentStep = 0;
var obSteps = [
  {
    label: '\u0627\u0644\u062e\u0637\u0648\u0629 \u0661 \u0645\u0646 \u0666',
    title: '\u0645\u0631\u062d\u0628\u0627\u064b\u060c \u0645\u0627 \u0627\u0633\u0645\u0643\u061f \ud83d\udc4b',
    content: '<p style="font-size:0.82rem;color:var(--ink-l);margin-bottom:16px;font-weight:400;">\u0627\u0644\u0627\u0633\u0645 \u0633\u064a\u0638\u0647\u0631 \u0644\u0643 \u0641\u064a \u062a\u0642\u0627\u0631\u064a\u0631\u0643 \u0627\u0644\u062f\u0631\u0627\u0633\u064a\u0629</p><div class="form-group"><label class="form-label" style="text-align:right;display:block;">\u0627\u0644\u0627\u0633\u0645 \u0627\u0644\u0643\u0627\u0645\u0644</label><input class="form-input" id="ob-user-name" type="text" placeholder="\u0645\u062b\u0644\u0627\u064b: \u062e\u0627\u0644\u062f \u0628\u0646 \u0641\u0647\u062f" dir="rtl" oninput="var v=this.value; localStorage.setItem(\'userName\',v); localStorage.setItem(\'userAvatar\',v.substring(0,2));"></div>'
  },
  {
    label: '\u0627\u0644\u062e\u0637\u0648\u0629 \u0662 \u0645\u0646 \u0666',
    title: '\u0645\u0631\u062d\u0628\u0627\u064b \u0628\u0643 \u0641\u064a \u062a\u062d\u0635\u064a\u0644\u064a \u26a1',
    content: '<p style="font-size:0.9rem;color:var(--ink-l);margin-bottom:24px;line-height:1.6;">\u0647\u0630\u0627 \u0627\u0644\u062a\u0637\u0628\u064a\u0642 \u0645\u0635\u0645\u0645 \u0644\u0645\u0633\u0627\u0639\u062f\u062a\u0643 \u0641\u064a \u0627\u0644\u062d\u0635\u0648\u0644 \u0639\u0644\u0649 \u0623\u0639\u0644\u0649 \u062f\u0631\u062c\u0629 \u0641\u064a \u0627\u062e\u062a\u0628\u0627\u0631 \u0627\u0644\u062a\u062d\u0635\u064a\u0644\u064a.</p><div style="background:var(--g-lt);border-radius:18px;padding:20px;text-align:center;"><div style="font-weight:700;color:var(--g-dark);">\u062e\u0648\u0627\u0631\u0632\u0645\u064a\u0629 \u0630\u0643\u064a\u0629</div><div style="font-size:0.75rem;color:var(--ink-l);">\u062a\u062d\u062f\u062f \u0646\u0642\u0627\u0637 \u0636\u0639\u0641\u0643 \u0648\u062a\u0642\u0648\u064a\u0647\u0627 \u064a\u0648\u0645\u064a\u0627\u064b</div></div>'
  },
  {
    label: '\u0627\u0644\u062e\u0637\u0648\u0629 \u0663 \u0645\u0646 \u0666',
    title: '\u0627\u062e\u062a\u0631 \u0645\u0633\u0627\u0631\u0643 \u0627\u0644\u062f\u0631\u0627\u0633\u064a',
    content: '<div class="ob-option selected" onclick="selectOb(this)"><div class="ob-option-radio"></div><div class="ob-option-text"><div class="ob-option-main">\ud83d\udd2c \u0639\u0644\u0645\u064a</div><div class="ob-option-sub">\u0631\u064a\u0627\u0636\u064a\u0627\u062a \u00b7 \u0641\u064a\u0632\u064a\u0627\u0621 \u00b7 \u0643\u064a\u0645\u064a\u0627\u0621 \u00b7 \u0623\u062d\u064a\u0627\u0621</div></div></div><div class="ob-option disabled"><div class="ob-option-radio"></div><div class="ob-option-text"><div class="ob-option-main">\ud83d\udcda \u0623\u062f\u0628\u064a <span class="coming-badge">\u0642\u0631\u064a\u0628\u0627\u064b</span></div><div class="ob-option-sub">\u0639\u0631\u0628\u064a \u00b7 \u062a\u0627\u0631\u064a\u062e \u00b7 \u062c\u063a\u0631\u0627\u0641\u064a\u0627</div></div></div>'
  },
  {
    label: '\u0627\u0644\u062e\u0637\u0648\u0629 \u0664 \u0645\u0646 \u0666',
    title: '\u0623\u0646\u062a \u0641\u064a \u0623\u064a \u0635\u0641\u061f',
    content: '<div class="ob-option" onclick="selectOb(this)"><div class="ob-option-radio"></div><div class="ob-option-text"><div class="ob-option-main">\ud83c\udf93 \u0627\u0644\u0635\u0641 \u0627\u0644\u062b\u0627\u0646\u064a \u0627\u0644\u062b\u0627\u0646\u0648\u064a</div><div class="ob-option-sub">\u062a\u062d\u0636\u064a\u0631 \u0645\u0628\u0643\u0631 \u2014 \u0645\u0645\u062a\u0627\u0632!</div></div></div><div class="ob-option selected" onclick="selectOb(this)"><div class="ob-option-radio"></div><div class="ob-option-text"><div class="ob-option-main">\ud83c\udfaf \u0627\u0644\u0635\u0641 \u0627\u0644\u062b\u0627\u0644\u062b \u0627\u0644\u062b\u0627\u0646\u0648\u064a</div><div class="ob-option-sub">\u0627\u0644\u0633\u0646\u0629 \u0627\u0644\u062d\u0627\u0633\u0645\u0629</div></div></div>'
  },
  {
    label: '\u0627\u0644\u062e\u0637\u0648\u0629 \u0665 \u0645\u0646 \u0666',
    title: '\u0645\u062a\u0649 \u0627\u062e\u062a\u0628\u0627\u0631\u0643\u061f',
    content: '<p style="font-size:0.82rem;color:var(--ink-l);margin-bottom:16px;font-weight:400;">\u0627\u0644\u062a\u0637\u0628\u064a\u0642 \u0633\u064a\u0628\u0646\u064a \u062e\u0637\u062a\u0643 \u0628\u0646\u0627\u0621\u064b \u0639\u0644\u0649 \u0627\u0644\u0623\u064a\u0627\u0645 \u0627\u0644\u0645\u062a\u0628\u0642\u064a\u0629</p><input type="date" class="date-input" value="2026-06-15" oninput="updateDays(this.value)"><div style="background:var(--g-lt);border-radius:14px;padding:14px 18px;margin-top:8px;display:flex;gap:10px;align-items:center;"><div><div id="days-result" style="font-size:0.82rem;font-weight:700;color:var(--g-dark);">\u0667\u0661 \u064a\u0648\u0645 \u0645\u062a\u0628\u0642\u064a\u0629</div><div style="font-size:0.72rem;color:var(--ink-l);">\u062e\u0637\u0629 \u062f\u0631\u0627\u0633\u064a\u0629 \u0645\u0646\u0638\u0645\u0629 \u0628\u0627\u0646\u062a\u0638\u0627\u0631\u0643</div></div></div>'
  },
  {
    label: '\u0627\u0644\u062e\u0637\u0648\u0629 \u0666 \u0645\u0646 \u0666',
    title: '\u0643\u0645 \u0633\u0624\u0627\u0644 \u064a\u0648\u0645\u064a\u0627\u064b\u061f',
    content: '<div class="slider-wrap"><div class="slider-value"><div class="slider-num" id="slider-display">\u0662\u0660</div><div class="slider-label">\u0633\u0624\u0627\u0644 \u064a\u0648\u0645\u064a\u0627\u064b</div></div><input type="range" min="5" max="50" value="20" step="5" oninput="document.getElementById(\'slider-display\').textContent=(+this.value).toLocaleString(\'ar-SA\')"><div class="slider-hints"><span>\u0665 \u2014 \u0645\u0634\u063a\u0648\u0644</span><span>\u0662\u0665 \u2014 \u0645\u062a\u0648\u0633\u0637</span><span>\u0665\u0660 \u2014 \u062c\u0627\u062f</span></div></div>'
  }
];

function selectOb(el) {
  if (el.classList.contains('disabled')) return;
  var parent = el.parentElement;
  parent.querySelectorAll('.ob-option').forEach(function(opt) { opt.classList.remove('selected'); });
  el.classList.add('selected');
}
window.selectOb = selectOb;

function updateOb() {
  var step       = obSteps[obCurrentStep];
  var labelEl    = document.getElementById('ob-label');
  var titleEl    = document.getElementById('ob-title');
  var bodyEl     = document.getElementById('ob-body');
  var progressEl = document.querySelector('.ob-progress-inner');
  var backBtn    = document.getElementById('ob-back');

  if (labelEl)    labelEl.textContent    = step.label;
  if (titleEl)    titleEl.textContent    = step.title;
  if (bodyEl)     bodyEl.innerHTML       = step.content;
  if (progressEl) progressEl.style.width = ((obCurrentStep + 1) / obSteps.length * 100) + '%';
  if (backBtn)    backBtn.style.visibility = obCurrentStep === 0 ? 'hidden' : 'visible';

  if (typeof lucide !== 'undefined') lucide.createIcons();
}
window.updateOb = updateOb;

function obNext() {
  if (obCurrentStep === 0) {
    var nameInput = document.getElementById('ob-user-name');
    if (nameInput && !nameInput.value.trim()) {
      nameInput.style.border = '2px solid var(--red)';
      nameInput.focus();
      return;
    }
  }
  if (obCurrentStep < obSteps.length - 1) {
    obCurrentStep++;
    updateOb();
  } else {
    goTo('paywall');
  }
}
window.obNext = obNext;

function obBack() {
  if (obCurrentStep > 0) {
    obCurrentStep--;
    updateOb();
  } else {
    goTo('login');
  }
}
window.obBack = obBack;

// ════════ INIT ════════
document.addEventListener('DOMContentLoaded', function() {
  if (document.getElementById('ob-body')) updateOb();
  updateSubscriptionUI();
  updateProfileUI();
  if (document.getElementById('home-days')) initHomeCountdown();

  setTimeout(function() {
    updateSubscriptionUI();
    updateProfileUI();
  }, 150);
});
